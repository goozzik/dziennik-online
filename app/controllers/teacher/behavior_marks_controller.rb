class Teacher::BehaviorMarksController < ApplicationController

  def index
    @students = current_teacher.students
  end

  def update
    student = current_teacher.students.find(params[:mark][:student_id])
    mark = student.current_semester_behavior_mark
    if mark
      old_mark = mark.mark
      if mark.update_attributes(params[:mark])
        render js: "$('#mark_#{params[:mark][:student_id]}').html('#{mark.mark}');"
      else
        render js: "$('#mark_#{params[:mark][:student_id]}').html('#{old_mark}');"
      end
    else
      if student.behavior_marks.create(params[:mark])
        render js: "$('#mark_#{params[:mark][:student_id]}').html('#{params[:mark][:mark]}');"
      else
        render js: "$('#mark_#{params[:mark][:student_id]}').html('');"
      end
    end
  end

end
