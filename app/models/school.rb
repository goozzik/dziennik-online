class School < ActiveRecord::Base

  belongs_to :admin
  has_many :directors, :dependent => :destroy
  has_many :school_classes, :dependent => :destroy

end
