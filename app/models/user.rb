class AdvisorValidator < ActiveModel::Validator
  def validate(user)
    unless user.advisor
      if user.advised_by == -1
        user.errors[:You] << ' must choose an advisor'
      end
    end
  end
end

class User < ActiveRecord::Base
	  validates :email, presence: true, uniqueness: true
	  validates_format_of :email, with: /@calu.edu\Z/
  	has_secure_password
  	validates :password, presence: true, length: { minimum: 6 }, if: Proc.new { |a| !(a.password.blank?) }
    validates_with AdvisorValidator
    validates :major, presence: true
    has_many :transcripts
    has_many :schedules
    belongs_to :major
    
    serialize :minor, Array
    
    before_validation do |model|
      model.minor.reject!(&:blank?) if model.minor
    end
     
    def send_password_reset
      generate_token(:password_reset_token)
      self.password_reset_sent_at = Time.zone.now
      save!
      UserMailer.password_reset(self).deliver
    end
    
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end

    def send_for_approval
      UserMailer.submit_for_advising(self).deliver
    end
    
    def send_approval_submission_confirmation
      UserMailer.approval_submission_confirmation(self).deliver
    end

    def send_approved_confirmation
      UserMailer.approval_confirmation(self).deliver
    end
    
    def send_approved
      UserMailer.approved(self).deliver
    end    
    
end