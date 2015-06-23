class AdminUser < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :remember_me 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
end
