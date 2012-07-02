class SemesterAbsence

  attr_reader :absences

  def initialize(resource, semester)
    @absences = resource.absences.find_all_by_semester_id(semester)
  end

  def required
    @required ||= absences.map(&:required).delete_if(&:nil?).inject(0, &:+)
  end

  def justified
    @justified ||= absences.map(&:justified).delete_if {|a| a.nil?}.inject(0, &:+)
  end

  def unexcused
    @unexcused ||= absences.map(&:unexcused).delete_if {|a| a.nil?}.inject(0, &:+)
  end

  def late
    @late ||= absences.map(&:late).delete_if {|a| a.nil?}.inject(0, &:+)
  end

  def percentage
    percentage = sprintf("%1.2f", (required - (justified + unexcused)).to_f / required * 100)
    percentage == "NaN" ? "--" : percentage
  end

end
