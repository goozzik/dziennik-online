class Director::DocumentsController < Director::DirectorController

  def create
    document.save ? redirect_to(action:"index") : render(action:"new")
  end

  def destroy
    document.destroy && redirect_to(action:"index")
  end

  private

    def document
      if params[:id]
        @document ||= current_director.school_documents.find(params[:id])
      else 
        @document ||= current_director.documents.build(params[:document])
      end
    end

end
