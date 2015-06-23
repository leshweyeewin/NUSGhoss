class User < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :full_name, :profile_name, :email, :password, :password_confirmation, :remember_me
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :statuses, :dependent => :destroy 
    has_many :user_comments, :dependent => :destroy 

	def full_name
    	[first_name, last_name].join(' ')
	end
end
