# coding: utf-8
class User < ActiveRecord::Base

  ROLES = %w[superadmin admin director teacher student]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  belongs_to :school

  attr_accessible :email, :username, :password, :password_confirmation, :remember_me
  attr_protected :role

  validates_presence_of :role, :on => :create
  validate :validate_role_format, :on => :create

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def superadmin?
    role?("superadmin")
  end

  def admin?
    role?("admin")
  end

  def teacher?
    role?("teacher")
  end

  def director?
    role?("director")
  end

  def student?
    role?("student")
  end

  private

    def validate_role_format
      unless ROLES.include?(role)
        errors.add(:role, "nie prawidłowa rola")
        return false
      end
    end

end
