class Document < ActiveRecord::Base

  belongs_to :school_class
  belongs_to :school
  belongs_to :user, :polymorphic => true

  mount_uploader :document, DocumentUploader

  attr_accessible :name, :description, :document, :for_teachers

  attr_accessor :for_teachers

  before_validation :set_for_teachers_if_director, :set_relations

  validates_presence_of :name, :description, :document

  private

    def set_for_teachers_if_director
      for_teachers = "1" if user.director?
    end

    def set_relations
      if for_teachers == "1"
        self.school_id = user.school_id
      else
        self.school_class_id = user.school_class_id
      end
    end

end
