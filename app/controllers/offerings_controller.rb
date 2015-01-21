class OfferingsController < ApplicationController
  before_action :set_offering, only: [:destroy]
  before_filter :authorize
  
  def new
    @offering = Offering.new
  end

  def create
    @offering = Offering.new(offering_params)
    
    respond_to do |format|
      if @offering.save
       	flash[:notice] = @offering.course.title + " is now being offered!"
       	format.js { render :js => "window.location.href='"+offerings_path+"'"}
        format.html { redirect_to offerings_path, notice: @offering.course.title + " is now being offered!" }
        format.json { render :show, status: :created, location: @offering }
      else
        format.js { @errors = true}
        format.html { render :new }
        format.json { render json: @offering.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @offering.destroy
    respond_to do |format|
      format.html { redirect_to offerings_url, notice: @offering.course.title + " is no longer being offered!" }
      format.json { head :no_content }
    end
  end
  
  def index
    @offerings = Offering.all
  end
  
  def import
    if (File.extname(params[:offering_file].original_filename)).downcase == ".csv"
      Offering.import(params[:offering_file])
      respond_to do |format|
        format.html { redirect_to offerings_path, notice: "Offerings Uploaded!" }
      end
    else
      respond_to do |format|
        format.html { redirect_to new_offering_path, notice: "Only CSV files are acceptable!" }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offering
      @offering = Offering.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def offering_params
      params.require(:offering).permit(:course_id, :days_time_id, :user_id)
    end
    
    def parse_params
      params.require(:offering).permit(:uploaded_file)
    end
    
    def authorize
      logged_in = User.find_by_id(session[:user_id])
      if not (logged_in.advisor or logged_in.administrator)
        redirect_to user_transcripts_path(logged_in), notice: "You're not authorized to view this page!"
      end
    end
end
