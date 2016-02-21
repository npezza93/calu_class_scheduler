class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_active_semester, only: [:update]

  def index
    if current_user.advisor
      @advisees = User.where(
        advised_by: current_user, major_id: current_user.major_id
      )
      @all_others = User.where(
        advisor: false, administrator: false, major_id: current_user.major_id
      ).where.not(advised_by: current_user.id)
    end

    respond_to do |format|
      format.js { @page_num = params[:page], @page_num2 = params[:page_2], @page_num3 = params[:page_3]}
      format.html
    end
  end

  def new
    @user = User.new
    @majors = (Major.all.map { |major| [major.major, major.id] })
    @advisors = (User.where(advisor: true).map { |advisor| [advisor.email, advisor.id] })
  end

  def edit
    @session_user = User.find(session[:user_id])
    @advisors = User.where(advisor: true).map { |advisor| [advisor.email, advisor.id] }
    @majors = (Major.all.map { |major| [major.major, major.id] })
    @minors = (Major.all.map { |major| [major.major, major.id] if @user.major_id != major.id})
  end

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
            flash[:notice] = @user.first_name.capitalize+ " " + @user.last_name.capitalize + "'s settings were successfully updated!"
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
        t_pt = @user.pt_a
        if @user.update(student_params)
          if t_minors != @user.minor or t_major != @user.major or t_pt != @user.pt_a
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

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_active_semester
    @active_semester = Semester.where(active: true).take
  end

  def advisor_self_params
    params.require(:user).permit(:password, :password_confirmation, :major_id)
  end

  def advisor_student_params
    params.require(:user).permit(
      :advised_by, :advisor, :pt_a, :pt_b, :pt_c, :pt_d
    )
  end

  def student_params
    params.require(:user).permit(
      :password, :password_confirmation, :major_id,
      :pt_a, :pt_b, :pt_c, :pt_d, minor: []
    )
  end

  def new_user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :advised_by,
      :major_id, :advisor, :first_name, :last_name
    )
  end

  def only_edit_you
    logged_in = User.find_by_id(session[:user_id])
    going_to = User.find_by_id(params[:id])
    if !logged_in.advisor
      unless session[:user_id].to_i == params[:id].to_i
        redirect_to users_path, notice: 'You\'re not authorized to view this page!'
      end
    elsif (going_to != logged_in) && going_to.advisor
      redirect_to users_path, notice: 'You\'re not authorized to view this page!'
    end
  end
end
