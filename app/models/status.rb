class Status < ActiveRecord::Base
	attr_accessible :content, :user_id
	
	belongs_to :user
	has_many :user_comments, :dependent => :destroy

	validates_presence_of :content
end
