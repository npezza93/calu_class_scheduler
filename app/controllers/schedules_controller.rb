class SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_offering, only: :destroy
  before_action :set_hidden_offerings, except: :create
  authorize_resource

  def index
    @complete_categories = current_user.user_categories.completed
    @incomplete_categories = current_user.user_categories.incompleted

    @work_schedules = current_user.work_schedules.includes(:work_days_time)
    @schedules = current_user.offerings
  end

  def create
    @schedule = current_user.schedules.create(
      offering_id: params[:offering_id],
      semester: active_semester
    )
    set_hidden_offerings

    respond_to do |format|
      format.html { redirect_to schedules_path }
      format.js { render layout: false }
    end
  end

  def destroy
    current_user.schedules.find_by(offering: @offering).destroy

    respond_to do |format|
      format.html { redirect_to schedules_path }
      format.js { render layout: false }
    end
  end

  private

  def set_hidden_offerings
    @hidden_offerings = current_user.offerings_that_overlap
  end

  def set_offering
    @offering = Offering.find(params[:id])
  end
end
