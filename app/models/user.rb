class User < ActiveRecord::Base
  before_save :ensure_authentication_token

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
  # attr_accessible :first_name, :last_name, :email, :password, :password_confirmation,
  #                 :temp_password

  # validates :email, :first_name, :last_name, :presence => true
  # validates_uniqueness_of :email

end
