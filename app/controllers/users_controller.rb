class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_active_semester, only: [:update]
  before_filter :only_edit_you, only: [:edit, :update]
  before_filter :reg_user_check, only: [:index, :user_options, :destroy]
  skip_before_filter :logged_in?, only: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @logged_in = User.find_by_id(session[:user_id])
    
    if @logged_in.advisor
      @advisees = User.where(advised_by: @logged_in, major_id: @logged_in.major_id).page(params[:page]).per(5)
      @faculty = User.where(advisor: true, major_id: @logged_in.major_id).page(params[:page_3]).per(5)
      @all_others= User.where(advisor: false, administrator: false, major_id: @logged_in.major_id).where.not(advised_by: @logged_in.id).page(params[:page_2]).per(5)
    end
    
    respond_to do |format|
      format.js { @page_num = params[:page], @page_num2 = params[:page_2], @page_num3 = params[:page_3]}
      format.html
    end
  end
  
  def user_options
    @user = User.find_by_id(params[:advisee_id])
    
    respond_to do |format|
      format.js {}
    end
  end

  # GET /users/new
  def new
    @user = User.new
    @majors = (Major.all.map { |major| [major.major, major.id] }) << ["", "-1"]
    @advisors = (User.where(advisor: true).map { |advisor| [advisor.email, advisor.id] }) << ["", "-1"]
  end

  # GET /users/1/edit
  def edit
    @session_user = User.find(session[:user_id])
    @advisors = User.where(advisor: true).map { |advisor| [advisor.email, advisor.id] } << ["", "-1"]
    @majors = (Major.all.map { |major| [major.major, major.id] }) << ["", "-1"]
    @minors = (Major.all.map { |major| [major.major, major.id] if @user.major_id != major.id})
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(new_user_params)

    respond_to do |format|
      if @user.save
        if !session[:user_id]
          session[:user_id] = @user.id
        end
        if @user.advisor
          format.js { render :js => "window.location = '/users'", notice: 'Welcome'}
        else 
          format.js { render :js => "window.location = '/users/" + @user.id.to_s + "/schedules'" , notice: 'Welcome'+ @user.first_name.capitalize + " " + @user.last_name.capitalize}
        end
        format.html { redirect_to users_path, notice: 'Welcome' + @user.email }
        format.json { render :show, status: :created, location: @user }
      else
        format.js { @errors = true }
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if User.find(session[:user_id]).advisor
      if User.find(session[:user_id]) == @user
        respond_to do |format|
          if @user.update(advisor_self_params)
            flash[:notice] = "Your settings were successfully updated!"
            format.js {}
            format.html { redirect_to users_path, notice: "Your settings were successfully updated." }
          else
            format.js {}
            format.html { render :edit }
          end
        end
      else
        respond_to do |format|
          if @user.update(advisor_student_params)
            flash[:notice] = @user.email + "'s settings were successfully updated!"
            format.js {}
            format.html { redirect_to users_path, notice: @user.email + "'s settings were successfully updated!" }
          else
            format.js {}
            format.html { render :edit }
          end
        end
      end
    else
      respond_to do |format|
        t_minors = @user.minor
        t_major = @user.major
        if @user.update(student_params)
          if t_minors != @user.minor or t_major != @user.major
            Schedule.where(user: @user, semester: @active_semester).destroy_all
            @minor_flag = true
          end
          
          flash[:notice] = "Your settings were successfully updated!"
          format.js {}
          format.html { redirect_to users_schedule_path(@user), notice: "Your settings were successfully updated!" }
        else
          format.js {}
          format.html { render :edit }          
        end
      end    
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: @user.email + ' was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    
    def set_active_semester
      @active_semester = Semester.where(active: true).take
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def advisor_self_params
      params.require(:user).permit(:password, :password_confirmation, :major_id)
    end
    
    def advisor_student_params
      params.require(:user).permit(:advised_by, :advisor)
    end
    
    def student_params
      params.require(:user).permit(:password, :password_confirmation, :major_id, {:minor => []})
    end
          
    def new_user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :advised_by, :major_id, :advisor, :first_name, :last_name)
    end
    
    def only_edit_you
      logged_in = User.find_by_id(session[:user_id])
      going_to = User.find_by_id(params[:id])
      if not logged_in.advisor
        unless session[:user_id].to_i == params[:id].to_i
          redirect_to users_path, notice: "You're not authorized to view this page!"
        end
      else 
        if (going_to != logged_in)  and going_to.advisor
          redirect_to users_path, notice: "You're not authorized to view this page!"
        end
      end
    end
    
    def reg_user_check
      if not User.find_by_id(session[:user_id]).advisor
        redirect_to user_schedules_path(User.find_by_id(session[:user_id])), notice: "You're not authorized to view this page!"
      end
    end
end