# coding: utf-8
class Subject < ActiveRecord::Base

  belongs_to :school_class
  belongs_to :subject_template

  has_many :lessons, :dependent => :destroy
  has_many :descriptions, :dependent => :destroy

  attr_accessible :school_class_id, :subject_template_id

  validates :school_class_id, :presence => true
  validates :subject_template_id, :presence => true, :uniqueness => {:scope => :school_class_id, :message => "już istnieje w klasie"}

  def name
    subject_template.name
  end

  def school_class_semester
    school_class.semester
  end

end
