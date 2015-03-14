class MajorsController < ApplicationController
  before_action :set_major, only: [:destroy, :edit, :update]
  before_filter :authorize
  
  def index
    @majors = Major.all
  end
  
  def edit
  end
  
  def new
    @major = Major.new
  end

  def create
    @major = Major.new(major_params)

    respond_to do |format|
      if @major.save
       	flash[:notice] = @major.major + " has been created as a new major!"
       	format.js { render :js => "window.location.href='"+majors_path+"'"}
        format.html { redirect_to majors_path, notice: @major.major + " has been created as a new major!" }
      else
        format.html { render :new }
        format.js {}
      end
    end
  end
  
  def update
    respond_to do |format|
      if @major.update(major_params)
       	flash[:notice] = @major.major + " has been updated!"
       	format.js { render :js => "window.location.href='"+majors_path+"'"}
        format.html { redirect_to majors_path, notice: @major.major + " has been updated!" }
      else
        format.html { render :edit }
        format.js {}
      end
    end
  end
  
  def destroy
    @major.destroy
    respond_to do |format|
      format.html { redirect_to majors_path, notice: 'Major was successfully destroyed.'  }
    end
  end
private
    # Use callbacks to share common setup or constraints between actions.
    def set_major
      @major = Major.find(params[:id])
    end

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
