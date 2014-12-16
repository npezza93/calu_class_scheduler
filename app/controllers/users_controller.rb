class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authorize, only: [:show, :edit, :update, :destroy, :index]
  before_filter :authorize2, only: [:edit, :update]
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @logged_in = User.find_by_id(session[:user_id])
    if @logged_in.advisor
      @advisees = User.where(advised_by: @logged_in).page(params[:page]).per(5)
      @all_others= User.where(advisor: false, administrator: false).where.not(advised_by: @logged_in.id).page(params[:page_2]).per(5)
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
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { render :index, status: :ok, location: @user }
      else
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
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
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
      if session[:user_id] and (User.find_by_id(session[:user_id]).advisor or User.find_by_id(session[:user_id]).administrator) 
        params.require(:user).permit(:email, :password, :password_confirmation, :administrator, :advisor, :advised_by)
      else
        params.require(:user).permit(:email, :password, :password_confirmation, :advised_by)
      end
    end
    
    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end
    
    def authorize2
      logged_in = User.find_by_id(session[:user_id])
      going_to = User.find_by_id(params[:id])
      if not logged_in.advisor 
        if not logged_in.administrator
          unless session[:user_id].to_i == params[:id].to_i
            redirect_to users_path, notice: "You are not authorized to view this page"
          end
        else 
          if (going_to != logged_in)  and (going_to.advisor || going_to.administrator)
            redirect_to users_path, notice: "You are not authorized to view this page"
          end
        end
      else 
        if (going_to != logged_in)  and (going_to.advisor || going_to.administrator)
          redirect_to users_path, notice: "You are not authorized to view this page"
        end
      end
    end
end
