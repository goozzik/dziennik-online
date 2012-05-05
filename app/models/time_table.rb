# coding: utf-8

class TimeTable < ActiveRecord::Base

  belongs_to :school_class
  has_many :lessons

  attr_accessible :week_day, :lessons_attributes
  accepts_nested_attributes_for :lessons, :reject_if => lambda { |lesson| lesson[:subject_id].blank? }, :allow_destroy => true

  def week_day_name
    case week_day
    when 0
      'Niedziela'
    when 1
      'Poniedziałek'
    when 2
      'Wtorek'
    when 3
      'Środa'
    when 4
      'Czwartek'
    when 5
      'Piątek'
    when 6
      'Sobota'
    end
  end

end
