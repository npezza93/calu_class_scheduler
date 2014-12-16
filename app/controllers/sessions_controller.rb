class SessionsController < ApplicationController
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
       	  format.js { render :js => "window.location = '/users'"}
       	end
	  	else
	  	  format.js { @error = "Invalid email/password combination" }
      end
    end
  end

  def destroy
    @user = User.find_by(id: session[:user_id])
  	session[:user_id] = nil
  	respond_to do |format|
  		format.html { redirect_to login_path, notice: @user.email + ' logged out' } 
  	end
  end
end