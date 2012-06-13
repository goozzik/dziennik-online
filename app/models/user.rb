# coding: utf-8
class User < ActiveRecord::Base

  ROLES = %w[superadmin admin director teacher student]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  belongs_to :school

  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :user_role
  attr_protected :role
  attr_accessor :user_role

  before_validation :generate_username_and_password, :on => :create

  validates_presence_of :first_name, :last_name
  validates_presence_of :user_role, :on => :create
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

    def generate_username_and_password
      if role != "superadmin"
        begin
          random_string = rand(36**10).to_s(36)
        end unless User.find_by_username(random_string)
        self.username = random_string
        self.password = random_string
      end
    end

end
