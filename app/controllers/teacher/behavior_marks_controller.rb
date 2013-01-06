class Teacher::BehaviorMarksController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :school_class_has_active_semester?, :school_class_has_students?

  def index
  end

  def update
    student = current_teacher.students.find(params[:mark][:student_id])
    mark = student.current_semester_behavior_mark
    if mark
      old_mark = mark.mark
      if params[:mark][:mark] == "0"
        mark.destroy
        render js: "$('#behavior_mark_#{params[:mark][:student_id]}').html('');"
      else
        if mark.update_attributes(params[:mark])
          render js: "$('#behavior_mark_#{params[:mark][:student_id]}').html('#{mark.mark}');"
        else
          render js: "$('#behavior_mark_#{params[:mark][:student_id]}').html('#{old_mark}');"
        end
      end
    else
      if student.behavior_marks.create(params[:mark])
        render js: "$('#behavior_mark_#{params[:mark][:student_id]}').html('#{params[:mark][:mark]}');"
      else
        render js: "$('#behavior_mark_#{params[:mark][:student_id]}').html('');"
      end
    end
  end

end
