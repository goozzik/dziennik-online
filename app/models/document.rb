class Document < ActiveRecord::Base

  belongs_to :semester
  belongs_to :school_class

  mount_uploader :document, DocumentUploader

  attr_accessible :name, :description, :document
  before_create :inherit_from_semester

  private

    def inherit_from_semester
      self.school_class_id = semester.school_class_id
    end

end
