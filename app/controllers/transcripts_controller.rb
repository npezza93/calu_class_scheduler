class TranscriptsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transcript, only: :destroy
  before_action :set_transcripts, only: [:index, :create]
  authorize_resource

  def index
    @transcript = Transcript.new
  end

  def create
    @transcript = @transcripts.new(transcript_params)

    respond_to do |format|
      if @transcript.save
        remove_schedules
        flash[:notice] = @transcript.course.title + ' added!'
        format.html { redirect_to transcripts_path }
      else
        format.html { render :index }
      end
      format.js { render layout: false }
    end
  end

  def import
    if Transcript.import(params['Transcript'], current_user)
      Schedule.where(user: current_user, semester: active_semester).destroy_all
      notice = 'Transcript Uploaded successfullly!'
    else
      notice = 'Please Upload Correct Text!'
    end

    redirect_to transcripts_path, notice: notice
  end

  def destroy
    @transcript.destroy
    respond_to do |format|
      flash[:notice] = @transcript.course.title + ' removed!'
      format.html { redirect_to transcripts_path  }
      format.js { render layout: false }
    end
  end

  private

  def set_transcripts
    @transcripts = current_user.transcripts.includes(:course)
                               .order('courses.subject asc')
  end

  def set_transcript
    @transcript = Transcript.find(params[:id])
  end

  def transcript_params
    attrs = params.require(:transcript).permit(:course_id, :grade_c)
    unless attrs[:grade_c].blank?
      attrs[:grade_c_minus] = Transcript.c_minus?(attrs[:grade_c])
      attrs[:grade_c] = Transcript.c?(attrs[:grade_c])
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
