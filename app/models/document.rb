class Document < ActiveRecord::Base

  belongs_to :school_class
  belongs_to :school
  belongs_to :user, :polymorphic => true

  mount_uploader :document, DocumentUploader

  attr_accessible :name, :description, :document, :for_teachers

  attr_accessor :for_teachers

  before_validation :set_relations

  validates_presence_of :name, :description, :document

  private

    def set_relations
      if for_teachers == "1"
        self.school_id = user.school_id
      else
        self.school_class_id = Teacher.find(user.id).school_class.id
      end
    end

end
