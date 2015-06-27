class Status < ActiveRecord::Base
	attr_accessible :content, :user_id, :tag_list
	acts_as_taggable
	
	belongs_to :user
	has_many :user_comments, :dependent => :destroy

	validates_presence_of :content
	validates_presence_of :tag_list
	validate :must_exist_in_database

	def tag_list
	  tags.map(&:name).join(", ")
	end

	def tag_list=(names)
	  self.tags = names.split(",").map do |n|
	    ActsAsTaggableOn::Tag.where(name: n.strip).first_or_create!
	  end
	end

	def must_exist_in_database
		self.tags.each do |tag|
			errors.add(tag.name, ' must exist in User database, profile_name attribute') unless User.find_by_profile_name(tag.name) 
		end
	end
end
