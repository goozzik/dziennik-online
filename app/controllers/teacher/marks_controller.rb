class Teacher::MarksController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?, :school_class_has_active_semester?, :school_class_has_students?

  def update
    subject = current_teacher.subjects.find(params[:mark][:subject_id])
    description = subject.descriptions.find(params[:mark][:description_id])
    mark = description.marks.find_by_student_id(params[:mark][:student_id])
    if mark
      old_mark = mark.mark
      if params[:mark][:mark] == "0"
        mark.destroy
        render js: "$('#mark_#{params[:mark][:student_id]}_#{params[:mark][:description_id]}').html('');"
      else
        if mark.update_attributes(params[:mark])
          render js: "$('#mark_#{params[:mark][:student_id]}_#{params[:mark][:description_id]}').html('#{mark.mark}');"
        else
          render js: "$('#mark_#{params[:mark][:student_id]}_#{params[:mark][:description_id]}').html('#{old_mark}');"
        end
      end
    else
      if Mark.create(params[:mark])
        render js: "$('#mark_#{params[:mark][:student_id]}_#{params[:mark][:description_id]}').html('#{params[:mark][:mark]}');"
      else
        render js: "$('#mark_#{params[:mark][:student_id]}_#{params[:mark][:description_id]}').html('');"
      end
    end
  end

end
