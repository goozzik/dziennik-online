class Teacher::DocumentsController < ApplicationController

  before_filter :authenticate_teacher!
  before_filter :teacher_has_active_class?

  def index
    @document = Document.new
    @documents = current_teacher.school_class.documents
  end

  def create
    @document = current_teacher.school_class.documents.build(params[:document])
    @document.save ? redirect_to(:action => "index") : render(:action => "new")
  end

  def destroy
    document = current_teacher.school_class.documents.find(params[:id])
    document.destroy
    redirect_to(:controller => "documents", :action => "index")
  end

end
