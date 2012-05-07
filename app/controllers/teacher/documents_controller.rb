class Teacher::DocumentsController < ApplicationController

  before_filter :teacher_has_active_class?, :only => [:index]

  def index
    @document = Document.new
    @documents = current_teacher.school_class.documents
  end

  def create
    document = current_teacher.semester.documents.build(params[:document])
    document.save ? redirect_to(:action => "index") : render(:action => "index")
  end

  def destroy
    document = current_teacher.school_class.documents.find(params[:id])
    document.destroy
    redirect_to(:controller => "teacher/documents", :action => "index")
  end

end
