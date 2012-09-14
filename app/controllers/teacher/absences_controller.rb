# coding: utf-8
class Teacher::AbsencesController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :school_class_has_active_semester?, :school_class_has_students?
  before_filter :is_semester_archived?, :only => [:update]

  def index
    @month = Chronic.parse('monday this month', :now => (params[:date].nil? ? Time.now : Time.parse(params[:date])))
    @weeks = Absence.get_weeks_from_month(@month)
    @students = current_teacher.school_class.students
    @previous_month = Chronic.parse('monday last month', :now => @month)
    @next_month = Chronic.parse('monday next month', :now => @month)
  end

  def update
    student = current_teacher.school_class.students.find(params[:absence][:student_id])
    absence = student.absences.find_by_date_and_semester_id(params[:absence][:date], current_teacher.school_class.semester_id)
    if absence
      absence.update_attributes(params[:absence])
    else
      absence = Absence.new(params[:absence])
      absence.save
    end
  end

  def mass_required_update
    current_teacher.school_class.update_mass_required_absences(params[:absence])
  end

  def is_semester_archived?
    if current_teacher.semester.archived
      flash[:alert] = "Administrator szkoły zarchiwizował ten semestr. Dostępne jest tylko przeglądanie."
      redirect_to :back
    end
  end

end
