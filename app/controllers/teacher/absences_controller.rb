class Teacher::AbsencesController < ApplicationController

  before_filter :teacher_has_active_class?, :teacher_has_students?, :only => [:index]

  def index
    @month = Chronic.parse('monday this month', :now => (params[:date].nil? ? Time.now : Time.parse(params[:date])))
    @weeks = Absence.get_weeks_from_month(@month)
    @students = current_teacher.school_class.students
    @absences = Absence.find_all_by_students_and_dates(@students, @weeks)
    @previous_month = Chronic.parse('monday last month', :now => @month)
    @next_month = Chronic.parse('monday next month', :now => @month)
  end

  def update
    student = current_teacher.school_class.students.find(params[:absence][:student_id])
    absence = student.absences.find_by_date(params[:absence][:date])
    if absence
      absence.update_attributes(params[:absence])
    else
      absence = student.absences.build(params[:absence])
      absence.save
    end
  end

end
