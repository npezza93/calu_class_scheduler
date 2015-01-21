class SessionsController < ApplicationController
  before_action :set_user, only: [:destroy]
  skip_before_filter :logged_in?, only: [:new, :create, :destroy]

  def new
  end

  def create
  	@user = User.find_by(email: params[:email])
  	respond_to do |format|
	  	if @user and @user.authenticate(params[:password])
	  		session[:user_id] = @user.id 
        if @user.advisor || @user.administrator
          flash[:notice] = "Welcome back, " + @user.email + "!"
          format.js { render :js => "window.location = '/users'"}
       	else
       	  flash[:notice] = "Welcome back, " + @user.email + "!"
       	  format.js { render :js => "window.location.href='"+user_schedules_path(@user)+"'"}
       	end
	  	else
	  	  format.js { @error = "Invalid email/password combination" }
      end
    end
  end

  def destroy
  	session[:user_id] = nil
  	respond_to do |format|
  		format.html { redirect_to login_path, notice: @user.email + ' logged out' } 
  	end
  end
  
  private
    def set_user
      @user = User.find_by(id: session[:user_id])
    end
end