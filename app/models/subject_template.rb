class SubjectTemplate < ActiveRecord::Base

  default_scope :order => 'name ASC'

  has_many :subjects

  attr_accessible :name

  validates :name, :uniqueness => true

end
