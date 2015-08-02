class User < ActiveRecord::Base
	attr_accessible :profile_name, :ivle_id, :ivle_name, :email, :password, :password_confirmation, :remember_me
  acts_as_voter

	validates_uniqueness_of :ivle_id, :on => :create
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

    has_many :statuses, :dependent => :destroy
    has_many :user_comments, :dependent => :destroy


  def self.from_omniauth(auth)
    identity = Identity.find_for_oauth(auth)
    user = User.where(:email => auth.info.email).first

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def self.search(search)
      User.find_by_ivle_name(search) || User.find_by_profile_name(search)
  end
end
