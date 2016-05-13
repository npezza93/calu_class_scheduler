class TranscriptsController < ApplicationController
  before_action :set_transcript, only: :destroy
  authorize_resource

  def index
    @transcript = Transcript.new
    @transcripts = current_user.transcripts.includes(:course)
                               .order('courses.subject asc')
  end

  def create
    @transcripts = current_user.transcripts.includes(:course)
    @transcript = @transcripts.new(transcript_params)

    if @transcript.save
      remove_schedules
      redirect_to transcripts_path, notice: @transcript.course.title + ' added!'
    else
      render :index
    end
  end

  def import
    if Transcript.import(params['Transcript'], current_user)
      Schedule.where(user: current_user, semester: active_semester).destroy_all

      redirect_to transcripts_path,
                  notice: 'Transcript Uploaded successfullly!'
    else
      redirect_to transcripts_path,
                  notice: 'Please Upload Correct Text!'
    end
  end

  def destroy
    @transcript.destroy
    redirect_to transcripts_path, notice: @transcript.course.title + ' removed!'
  end

  private

  def set_transcript
    @transcript = Transcript.find(params[:id])
  end

  def transcript_params
    attrs = params.require(:transcript).permit(:course_id, :grade_c)
    unless attrs[:grade_c].blank?
      attrs[:grade_c_minus] = Transcript.c_minus?(attrs[:grade_c])
      attrs[:grade_c_minus] = Transcript.c?(attrs[:grade_c])
    end
    attrs
  end

  def remove_schedules
    current_user.schedules.find_by(
      offering: Offering.find_by(course: @transcript.course,
                                 semester: active_semester)
    ).try(:destroy)
  end
end
