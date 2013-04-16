class Message < ActiveRecord::Base

  default_scope :order => 'created_at ASC'

  belongs_to :school_class

  attr_accessible :body, :school_class_id, :title

  validates_presence_of :body, :title

end
