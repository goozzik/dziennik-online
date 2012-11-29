# coding: utf-8
class User < ActiveRecord::Base

  default_scope :order => 'last_name ASC, first_name ASC'

  ROLES = %w[superadmin admin director teacher student]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  belongs_to :school

  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :user_role
  attr_protected :role

  attr_accessor :user_role, :current_password

  before_validation :generate_username_and_password, :on => :create

  validates_presence_of :first_name, :last_name
  validates_presence_of :username, :on => :update
  validates_presence_of :user_role, :on => :create
  validate :validate_role_format, :on => :create

  def superadmin?
    role == "superadmin"
  end

  def admin?
    role == "admin"
  end

  def teacher?
    role == "teacher"
  end

  def director?
    role == "director"
  end

  def student?
    role == "student"
  end

  def update_password(params)
    update_attribute(:password, params[:password]) if validate_new_password(params)
  end

  def save_with_role
    case user_role
    when "nauczyciel"
      self.role = "teacher"
    when "administrator"
      self.role = "admin"
    when "dyrektor"
      self.role = "director"
    else
      errors.add(:user_role, "nieprawidłowa rola")
      return false
    end
    save
  end

  def news
    New.where(["#{self.role} = ?", true])
  end

  private

    def validate_role_format
      unless ROLES.include?(role)
        errors.add(:role, "nieprawidłowa rola")
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

    def validate_new_password(params)
      validate_new_password_presence(params[:password]) && validate_new_password_length(params[:password]) && validate_new_password_confirmation(params)
    end

    def validate_new_password_presence(param)
      if param.empty?
        errors.add(:password, "nie może być puste")
        return false
      end
      true
    end

    def validate_new_password_length(param)
      if param.length < 6
        errors.add(:password, "za krótkie")
        return false
      end
      true
    end

    def validate_new_password_confirmation(params)
      if params[:password] != params[:password_confirmation]
        errors.add(:password_confirmation, "potwierdzenie hasła nie zgadza się")
        return false
      end
      true
    end

end
