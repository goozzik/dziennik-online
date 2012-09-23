class Absence < ActiveRecord::Base

  belongs_to :student
  belongs_to :semester
  belongs_to :school_class

  attr_accessible :date, :required, :justified, :unexcused, :late, :student_id

  before_create :set_semester_id, :set_school_class_id

  def self.get_weeks_from_month(date)
    weeks = []
    month = date.month
    while date.month == month do
      weeks << date.strftime('%Y-%m-%d')
      date = Chronic.parse('next monday', :now => date)
    end
    weeks
  end


  def self.parse_first_monday(date)
    check_chronic_parse(Chronic.parse('monday this month', now: date))
  end

  def self.parse_monday_last_month(date)
    check_chronic_parse(Chronic.parse('monday last month', now: date))
  end

  def self.parse_monday_next_month(date)
    check_chronic_parse(Chronic.parse('monday next month', now: date))
  end

  private

    def set_semester_id
      self.semester_id = student.semester_id
    end

    def set_school_class_id
      self.school_class_id = student.school_class_id
    end

    #check if time - week is 1st day of month
    #chronic gem is not working properly and this is temporary patch
    def self.check_chronic_parse(date)
      _date = date - 604_800
      date.month == _date.month && _date.monday? ? _date : date
    end

end
