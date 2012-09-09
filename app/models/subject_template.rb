class SubjectTemplate < ActiveRecord::Base

  has_and_belongs_to_many :profile_templates

  default_scope :order => 'name ASC'

  has_many :subjects

  attr_accessible :name

  validates :name, :uniqueness => true
  

end
