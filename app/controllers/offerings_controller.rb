class OfferingsController < ApplicationController
  before_action :set_offering, only: [:destroy, :edit, :update]
  before_action :set_offerings, only: [:index]
  before_action :set_file_ext, only: [:import]

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
      else
        format.js { @errors = true}
        format.html { render :new }
      end
    end
  end

  def edit
    @courses = Course.all.order(:course).map do |course|
      [course.subject + course.course.to_s + ": " + course.title, course.id]
    end
    @days_n_times = DaysTime.all.map do |day_time|
      if (day_time.days == "ONLINE" or day_time.days == "OFFSITE")
        [day_time.days, day_time.id]
      else
        [day_time.days + ' at ' + day_time.start_time + ' to ' + day_time.end_time, day_time.id]
      end
    end
    @instructors = User.where(advisor: true).map do |advisor|
      [advisor.email, advisor.id]
    end
  end

  def update
    respond_to do |format|
      if @offering.update(offering_params)
       	flash[:notice] = @offering.course.title + " successfully updated!"
       	format.js { render :js => "window.location.href='"+offerings_path+"'"}
        format.html { redirect_to offerings_path, notice: @offering.course.title + " successfully updated!" }
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
    Schedule.where(offering: @offering).delete_all
    respond_to do |format|
      format.html { redirect_to offerings_url, notice: @offering.course.title + " is no longer being offered!" }
      format.json { head :no_content }
    end
  end

  def index
  end

  def import
    if  @ext == ".csv"
      Offering.import(parse_params)
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

  def set_offering
    @offering = Offering.find(params[:id])
  end

  def set_file_ext
    @ext = File.extname(params[:offering_file].original_filename).downcase
  end

  def offering_params
    params.require(:offering).permit(:course_id, :days_time_id, :user_id,
                                     :section)
  end

  def parse_params
    params.require(:offering_file)
  end

  def set_offerings
    @active_semester = Semester.where(active: true).take
    @offerings = Offering.where(semester: @active_semester)
  end
end
