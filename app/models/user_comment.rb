class UserComment < ActiveRecord::Base
  attr_accessible :content, :status_id, :user_id

  belongs_to :status
  belongs_to :user

  validates_presence_of :content
end
