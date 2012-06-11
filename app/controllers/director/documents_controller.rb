class Director::DocumentsController < ApplicationController

  before_filter :authenticate_director!
  before_filter :set_for_teachers, :only => [:create]

  def index
    @document = Document.new
    @documents = current_director.school.documents
  end

  def create
    @document = current_director.documents.build(params[:document])
    @document.save ? redirect_to(:action => "index") : render(:action => "new")
  end

  def destroy
    document = current_director.school.documents.find(params[:id])
    document.destroy
    redirect_to action: "index"
  end

  private

    def set_for_teachers
      params[:document][:for_teachers] = "1"
    end

end
