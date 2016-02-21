class MajorsController < ApplicationController
  before_action :set_major, only: [:destroy, :edit, :update]
  before_action :set_majors, only: [:index, :create]
  before_filter :authorize

  def index
  end

  def edit
  end

  def create
    @major = Major.new(major_params)

    if @major.save
      redirect_to majors_path, notice: @major.major + ' is a new major!'
    else
      flash[:notice] = @major.errors.full_messages.first
      render :index
    end
  end

  def update
    if @major.update(major_params)
      redirect_to majors_path, notice: @major.major + ' has been updated!'
    else
      render :edit
    end
  end

  def destroy
    @major.destroy
    redirect_to majors_path, notice: 'Major was successfully destroyed.'
  end

  private

  def set_major
    @major = Major.find(params[:id])
  end

  def set_majors
    @majors = Major.all
  end

  def major_params
    params.require(:major).permit(:major)
  end

  def authorize
    unless current_user.advisor || current_user.administrator
      redirect_to user_transcripts_path(logged_in),
                  notice: 'You\'re not authorized to view this page!'
    end
  end
end
