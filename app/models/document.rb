class Document < ActiveRecord::Base

  belongs_to :school_class

  mount_uploader :document, DocumentUploader

  attr_accessible :name, :description, :document

  validates_presence_of :name, :description, :document

end
