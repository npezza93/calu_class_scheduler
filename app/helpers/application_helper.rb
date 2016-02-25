module ApplicationHelper
  def create_day_hash(offerings)
    day_hash = init_day_hash
    offerings.each do |course|
      day_hash['Monday'] << course if course.days_time.days.include? 'M'
      day_hash['Tuesday'] << course if course.days_time.days.include? 'T'
      day_hash['Wednesday'] << course if course.days_time.days.include? 'W'
      day_hash['Thursday'] << course if course.days_time.days.include? 'R'
      day_hash['Friday'] << course if course.days_time.days.include? 'F'
    end
    day_hash
  end

  def init_day_hash
    {
      'Monday' => [],
      'Tuesday' => [],
      'Wednesday' => [],
      'Thursday' => [],
      'Friday' => []
    }
  end
end
