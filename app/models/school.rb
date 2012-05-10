class School < ActiveRecord::Base

  belongs_to :admin
  has_many :directors, :dependent => :destroy
  has_many :teachers, :dependent => :destroy
  has_many :students, :dependent => :destroy
  has_many :school_classes, :dependent => :destroy

end
