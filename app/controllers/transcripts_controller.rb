# frozen_string_literal: true

# SchedulerJob.perform_now current_user, @transcript.course_id
class TranscriptsController < ApplicationController
  authorize_resource
  before_action :set_transcript, only: :destroy

  def index
    @transcripts =
      current_user.transcripts.includes(:course).order("courses.subject asc")
  end

  def new
    @transcript = current_user.transcripts.new
  end

  def create
    @transcript = current_user.transcripts.new(transcript_params)

    if @transcript.save && remove_schedule(@transcript)
      redirect_to transcripts_path, notice: "Course added to transcript"
    else
      render :new
    end
  end

  def destroy
    @transcript.destroy

    redirect_to transcripts_path, notice: "Course removed from transcript"
  end

  private

  def set_transcript
    @transcript = current_user.transcripts.find(params[:id])
  end

  def transcript_params
    params.require(:transcript).permit(:course_id, :grade_c).tap do |attrs|
      next if attrs[:grade_c].blank?

      attrs[:grade_c_minus] =
        Transcript::GRADES.index(attrs[:grade_c]).to_i <= 7
      attrs[:grade_c] =
        Transcript::GRADES.index(attrs[:grade_c]).to_i <= 6
    end
  end

  def remove_schedule(transcript)
    schedule = current_user.schedules.joins(:offering).find_by(
      offerings: { course: transcript.course, semester: current_semester }
    )

    return true if schedule.blank?

    schedule.destroy
  end
end
