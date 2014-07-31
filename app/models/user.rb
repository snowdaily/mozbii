class User < ActiveRecord::Base
  before_save :ensure_authentication_token, :except => [:create]

  # attr_accessor :email
  # has_secure_password
  # has_secure_password

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
  # attr_accessible :first_name, :last_name, :email, :password, :password_confirmation,
  #                 :temp_password

  # attr_accessible :email
  validates_confirmation_of :password, :on => :create#, message: 'should match confirmation'

  # validates :email, :first_name, :last_name, :presence => true
  # validates_uniqueness_of :email

  has_many :works
end
