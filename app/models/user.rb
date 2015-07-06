class User < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :full_name, :profile_name, :email, :password, :password_confirmation, :remember_me
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :statuses, :dependent => :destroy 
    has_many :user_comments, :dependent => :destroy 

	def full_name
    	[first_name, last_name].join(' ')
	end

  def self.search(search)
      User.find_by_first_name(search) || User.find_by_last_name(search) || User.find_by_profile_name(search) 
  end
end
