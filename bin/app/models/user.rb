class User < ActiveRecord::Base
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: /@calu.edu\Z/, message: "must be a CalU email address" }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, if: Proc.new { |a| !(a.password.blank?) }

    validates :major, presence: true
    validates :advised_by, presence: true, if: "not advisor"

    has_many :transcripts
    has_many :taken_courses, through: :transcripts, source: :course

    belongs_to :major

    has_many :schedules, -> { where(semester: Semester.where(active: true).take) }    
    has_many :offerings, through: :schedules  
    has_many :courses, through: :offerings
    
    has_many :work_schedules, -> { where(semester: Semester.where(active: true).take) }   
    has_many :work_days_times, through: :work_schedules

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
    
    def cached_transcripts_course
      Rails.cache.fetch([self, "transcripts_course"]) { transcripts.includes(:course) }
    end

    def scheduler
      category_courses_tf = Hash.new
      completed_category_courses, incomplete_category_courses = Hash.new, Hash.new

      used_courses = Set.new
      needs_list = []
      math_classes = []
      mat_181 = Course.where(subject: "MAT", course: "181").take
      mat_191 = Course.where(subject: "MAT", course: "191").take
      mat_199 = Course.where(subject: "MAT", course: "199").take
      mat_281 = Course.where(subject: "MAT", course: "281").take
      active_semester = Semester.where(active: true).take

      user_courses = self.taken_courses
      transcripts = self.transcripts
      
      categories = CurriculumCategory.where("(major_id = ? and minor =?) or (minor = ? and major_id IN (?))", self.major.id, false, true, self.minor).includes(:courses, curriculum_category_sets: [{courses: [:prerequisites, :offerings]}, {course_set: {course: [:prerequisites, :offerings]}}])
      
      categories.each do |category|
        sets = []
        completed_category_courses[category] = {}
        incomplete_category_courses[category] = {}

        category.curriculum_category_sets.each do |set|
          set_mapping = set.courses.map { |course| user_courses.include?(course) ? true : false }
          count = set.count
          if count != nil and set_mapping.grep(true).count < count
            sets << false
            incomplete_category_courses[category][set] = set.courses - user_courses
            completed_category_courses[category][set] = set.courses & user_courses
          elsif count != nil and set_mapping.grep(true).count >= count
            sets << true
            completed_category_courses[category][set] = set.courses & user_courses
          elsif count == nil
            sets << set_mapping.inject(:&)
            if set_mapping.inject(:&)
              completed_category_courses[category][set] = set.courses & user_courses
            else
              incomplete_category_courses[category][set] = set.courses - user_courses
              completed_category_courses[category][set] = set.courses & user_courses
            end
          end
        end

        if (category.set_and_or_flag ? sets.compact.inject(:|) : sets.compact.inject(:&))
          completed_category_courses[category] = (category.courses & user_courses).uniq     
          incomplete_category_courses.delete(category)
          if category.set_and_or_flag
            completed_category_courses[category] = (category.curriculum_category_sets[sets.index(true)].courses & user_courses).uniq
          end
        else
          if category.set_and_or_flag
            incomplete_category_courses[category] = incomplete_category_courses[category].select do |key, value|
              value.count == incomplete_category_courses[category].map { |k,v| v.count }.min
            end
            completed_category_courses[category] = completed_category_courses[category].select do |key, value|
              value.count == completed_category_courses[category].map { |k,v| v.count }.max
            end
            temp_set = completed_category_courses[category].keys.first
            temp_courses = completed_category_courses[category].values.flatten.uniq
            completed_category_courses[category]= {}
            completed_category_courses[category][temp_set] = temp_courses
          end
          incomplete_category_courses[category] = prerequisite_check(incomplete_category_courses[category].values.flatten, user_courses, self, transcripts)
          used_courses.merge(incomplete_category_courses[category])
          incomplete_category_courses[category].each do |course|
            if course == mat_181 or course == mat_191 or course == mat_199 or course == mat_281
              math_classes << [course, category]
            end          
          end
          incomplete_category_courses[category].map! { |course| course.offerings }
          incomplete_category_courses[category] = incomplete_category_courses[category].flatten
        end
      end

      if not math_classes.empty? and ((math_class_placed_in = math_pt(self, transcripts, math_classes, mat_181, mat_191, mat_199, mat_281, user_courses)) != nil) and used_courses.add?(math_class_placed_in[0])
        offerings = Offering.where(course: math_class_placed_in[0], semester: active_semester).flatten
        if not offerings.blank?
          incomplete_category_courses[math_class_placed_in[1]] += offerings
        end
      end

      return completed_category_courses, incomplete_category_courses
    end

  def prerequisite_check(courses, user_courses, user, transcripts)
    ok_courses = []
    courses.each do |course|
      begin
      grouped_prerequisites = course.prerequisites.group_by(&:course_group_id)
      
      if not grouped_prerequisites.blank?
        grouped_prerequisites.each do |group_id, prereq_group|
          prereq_group.map! do |prereq| 
            passed, failed_grade = prereq_grade_checker(prereq, user_courses, transcripts)
            if passed 
              true
            else
              if failed_grade != nil
                ok_courses << failed_grade
              end
              false
            end
          end
          grouped_prerequisites[group_id] = prereq_group.inject(:&)
        end
        
        if course.minimum_pt == "" or course.minimum_pt == nil
          if grouped_prerequisites.values.inject(:|) and class_standing_compare(user.class_standing,course.minimum_class_standing) and sat_check(user, course.minimum_sat_score)
            ok_courses << course
          end
        else
          if grouped_prerequisites.values.inject(:|) or pt_check(user, course.minimum_pt) or sat_check(user, course.minimum_sat_score)
            ok_courses << course
          end
        end
      else
        if course.minimum_pt == "" or course.minimum_pt == nil
          if class_standing_compare(user.class_standing,course.minimum_class_standing) and sat_check(user, course.minimum_sat_score)
            ok_courses << course
          end
        else
          if pt_check(user, course.minimum_pt) or sat_check(user, course.minimum_sat_score)
            ok_courses << course
          end
        end
      end
      rescue
      end
    end
    return ok_courses
  end

  def class_standing_compare(users_standing, min_standing)
    if min_standing == nil
      return true
    elsif users_standing == nil
      return false
    else
      standings = {1 => "Senior", 2 => "Junior", 3 => "Sophmore", 4 => "Freshman" }
      users = standings.select { |k,v| v.include? users_standing }
      min = standings.select { |k,v| v.include? min_standing }
      if users.keys[0] <= min.keys[0]
        return true
      else 
        return false
      end
    end
  end
  
  def sat_check(user, min_sat)
    if min_sat == "" or min_sat == nil
      return true
    elsif min_sat == "520"
      if user.sat_520
        return true
      else
        return false
      end
    elsif min_sat == "580"
      if user.sat_580
        return true
      else
        return false
      end
    elsif min_sat == "700"
      if user.sat_700
        return true
      else
        return false
      end
    elsif min_sat == "640"
      if user.sat_640
        return true
      else
        return false
      end
    elsif min_sat == "440"
      if user.sat_440
        return true
      else
        return false
      end
    end
  end
  
  def prereq_grade_checker(prereq, user_courses, transcripts)
    if user_courses.include?(prereq.prerequisite_course)
      if (prereq.minimum_grade == nil) or (prereq.minimum_grade == "C" and (transcripts.select { |transcript| transcript.course_id == prereq.prerequisite_course.id})[0].grade_c) or (prereq.minimum_grade == "C-" and (transcripts.select { |transcript| transcript.course_id == prereq.prerequisite_course.id})[0].grade_c_minus)
        return true, nil
      else 
        return false, prereq.prerequisite_course
      end
    else 
      return false, nil
    end
  end
  
  def pt_check(user, min_pt)
    case min_pt
    when "A"
      user.pt_a == 1 ? true : false
    when "B"
      user.pt_b == 1 ? true : false
    when "C"
      user.pt_c == 1 ? true : false
    when "D-"
      user.pt_d == 1 ? true : false
    when "D"
      user.pt_d == 3 ? true : false
    else
      false
    end
  end
  
  def math_pt(user, transcripts, math_classes, mat_181, mat_191, mat_199, mat_281, user_courses)
    math_courses = math_classes.collect { |course| course[0] }
    categories = math_classes.collect { |course| course[1] }
    
    mat_prereq = Hash.new
    mat_prereq[mat_281] = (prerequisite_check([mat_281], user_courses, user, transcripts)).include?mat_281
    mat_prereq[mat_199] = (prerequisite_check([mat_199], user_courses, user, transcripts)).include?mat_199
    mat_prereq[mat_191] = (prerequisite_check([mat_191], user_courses, user, transcripts)).include?mat_191
    mat_prereq[mat_181] = (prerequisite_check([mat_181], user_courses, user, transcripts)).include?mat_181

    if not mat_prereq.values.inject(:|)
      dma = Course.where(subject: "DMA", course: 92).take
      if (prerequisite_check([dma], user_courses, user, transcripts)).include?dma
        return [dma, categories.sort.last]
      else 
        return nil
      end
    else
      highest_avail = mat_prereq.select { |k,v| v and (not user_courses.include?k) }
      return [highest_avail.first[0], categories.sort.last]
    end
  end

  def cached_scheduler
    Rails.cache.fetch([self, "scheduler"]) { self.scheduler }
  end
end