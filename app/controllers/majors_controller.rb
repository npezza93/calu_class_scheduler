class MajorsController < ApplicationController
  before_filter :authorize
  
  def new
    @major = Major.new
  end

  def create
    @major = Major.new(major_params)

    respond_to do |format|
      if @major.save
       	flash[:notice] = @major.major + " has been created as a new major!"
       	format.js { render :js => "window.location.href='"+users_path+"'"}
        format.html { redirect_to users_path, notice: @major.major + " has been created as a new major!" }
        format.json { render :show, status: :created, location: @major }
      else
        format.html { render :new }
        format.js {}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
private
  # Never trust parameters from the scary internet, only allow the white list through.
    def major_params
        params.require(:major).permit(:major)
    end
    
    def authorize
      logged_in = User.find_by_id(session[:user_id])
      if not (logged_in.advisor or logged_in.administrator)
        redirect_to user_transcripts_path(logged_in), notice: "You're not authorized to view this page!"
      end
    end
end
