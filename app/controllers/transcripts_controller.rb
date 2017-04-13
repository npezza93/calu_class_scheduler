# frozen_string_literal: true

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

    @service = Transcripts::Create.new(
      @transcript, current_user, current_semester_id
    )

    if @service.perform
      redirect_to transcripts_path, notice: "Course added to transcript"
    else
      render :new
    end
  end

  def destroy
    @service = Transcripts::Destroy.new(
      @transcript, current_user, current_semester_id
    )
    @service.perform

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
end
