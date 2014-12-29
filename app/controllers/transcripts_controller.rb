class TranscriptsController < ApplicationController
  before_action :set_user, only: [:create, :index]
  before_action :set_transcript, only: [:index]
  before_filter :only_yours
  
  def index
  end
  
  def create
    @transcript = @user.transcripts.create(transcript_params)
    @transcript.user_id= @user.id
    
    respond_to do |format|
      if @transcript.save
        format.html { redirect_to user_transcripts_path, notice: "you have taken this course" }
        format.js {}
      else
        format.html { render :index }
        format.js { @errors = true }
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def set_transcript
      @transcript = Transcript.new
    end
    
    def transcript_params
      params.require(:transcript).permit(:course_id)
    end   
    
    def only_yours
      logged_in = User.find_by_id(session[:user_id])
      # going_to = User.find_by_id(params[:id])
      if not (logged_in.advisor or logged_in.administrator)
        unless params[:user_id].to_i == session[:user_id].to_i
          redirect_to user_transcripts_path(logged_in)
        end
      else
        if User.find_by_id(params[:user_id]).advisor or User.find_by_id(params[:user_id]).administrator
          redirect_to users_path, notice: "Admins and Advisors don't have transcripts!"
        end
      end
    end
end