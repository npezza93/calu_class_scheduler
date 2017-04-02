# frozen_string_literal: true

class SchedulesController < ApplicationController
  before_action :set_offering, only: :destroy
  authorize_resource

  def index
    schedules_categories = current_user.schedules_categories.for_semester(
      current_semester
    ).eager_load(
      :curriculum_category, :courses,
      category_offerings: [offering: %i(course days_time user)]
    )

    @completed_categories = schedules_categories.select(&:completed?)
    @incomplete_categories = schedules_categories.reject(&:completed?)

    # @schedules = current_user.offerings
  end

  def create
    @schedule = current_user.schedules.create(
      offering_id: params[:offering_id], semester: current_semester
    )

    respond_to do |format|
      format.html { redirect_to schedules_path }
      format.js
    end
  end

  def destroy
    current_user.schedules.find_by(offering: @offering).destroy

    respond_to do |format|
      format.html { redirect_to schedules_path }
      format.js
    end
  end

  private

  def set_offering
    @offering = Offering.find(params[:id])
  end
end
