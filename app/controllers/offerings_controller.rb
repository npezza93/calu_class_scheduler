class OfferingsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @offerings = Offering.search(params[:search], params[:page])
  end

  def new
  end

  def edit
  end

  def create
    @offering = Offering.new(offering_params)

    if @offering.save
      redirect_to offerings_path,
                  notice: @offering.course.title + ' is now being offered!'
    else
      render :new
    end
  end

  def update
    if @offering.update(offering_params)
      redirect_to offerings_path,
                  notice: @offering.course.title + ' successfully updated!'
    else
      render :new
    end
  end

  def destroy
    @offering.destroy
    Schedule.where(offering: @offering).delete_all
    redirect_to offerings_url,
                notice: @offering.course.title + ' is no longer being offered!'
  end

  def import
    if File.extname(params[:offering_file].original_filename) == '.csv'
      Offering.import(params[:offering_file])
      redirect_to offerings_path, notice: 'Offerings Uploaded!'
    else
      redirect_to new_offering_path, notice: 'Only CSV files are acceptable!'
    end
  end

  private

  def offering_params
    params.require(:offering).permit(:course_id, :days_time_id, :user_id,
                                     :section)
  end
end
