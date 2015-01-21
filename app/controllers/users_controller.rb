class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
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
      @all_others= User.where(advisor: false, administrator: false, major_id: @logged_in.major_id).where.not(advised_by: @logged_in.id).page(params[:page_2]).per(5)
    end
    
    respond_to do |format|
      format.js { @page_num = params[:page], @page_num2 = params[:page_2]}
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
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        if !session[:user_id]
          session[:user_id] = @user.id
        end
        format.js { render :js => "window.location = '/users'", notice: 'Welcome'}
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
    respond_to do |format|
      if @user.update(user_params)
        if User.find(session[:user_id]).advisor or User.find(session[:user_id]).administrator
          format.html { redirect_to users_path, notice: @user.email + " was successfully updated." }
        else
          format.html {redirect_to users_schedule_path(@user), notice: 'Password was successfully changed!' }
        end
        format.json { render :index, status: :ok, location: @user }
        flash[:notice] = "Password was successfully changed!"
        format.js {}
      else
        format.js {}
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      if session[:user_id] and ((User.find_by_id(session[:user_id]).advisor or User.find_by_id(session[:user_id]).administrator))
        if @user.administrator or @user.advisor
          params.require(:user).permit(:password, :password_confirmation)
        else
          params.require(:user).permit(:advised_by, :major_id, :advisor, :administrator)
        end
      else
        params.require(:user).permit(:email, :password, :password_confirmation, :advised_by, :major_id)
      end
    end
    
    def only_edit_you
      logged_in = User.find_by_id(session[:user_id])
      going_to = User.find_by_id(params[:id])
      if not (logged_in.advisor  or logged_in.administrator)
        unless session[:user_id].to_i == params[:id].to_i
          redirect_to users_path, notice: "You're not authorized to view this page!"
        end
      else 
        if (going_to != logged_in)  and (going_to.advisor || going_to.administrator)
          redirect_to users_path, notice: "You're not authorized to view this page!"
        end
      end
    end
    
    def reg_user_check
      logged_in = User.find_by_id(session[:user_id])
      if not (logged_in.advisor or logged_in.administrator)
        redirect_to user_transcripts_path(logged_in), notice: "You're not authorized to view this page!"
      end
    end
end