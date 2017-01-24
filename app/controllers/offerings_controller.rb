# frozen_string_literal: true
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
      redirect_to offerings_path, notice: @offering.course.title + " created!"
    else
      render :new
    end
  end

  def update
    if @offering.update(offering_params)
      redirect_to offerings_path, notice: @offering.course.title + " updated!"
    else
      render :new
    end
  end

  def destroy
    @offering.destroy
    Schedule.where(offering: @offering).delete_all

    redirect_to offerings_url, notice: @offering.course.title + " removed!"
  end

  def import
    Offering.import(params[:offering_file])

    redirect_to offerings_path, notice: "Offerings Uploaded!"
  end

  private

  def offering_params
    params.require(:offering).permit(
      :course_id, :days_time_id, :user_id, :section
    )
  end
end
