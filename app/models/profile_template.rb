class ProfileTemplate < ActiveRecord::Base

  belongs_to :school
  has_and_belongs_to_many :subject_templates
  has_many :school_classes

  attr_accessible :name, :start_year, :school_id, :subject_templates

  default_scope :order => 'start_year DESC'

end
