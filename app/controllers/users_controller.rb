class UsersController < ApplicationController
  def index
  	@users = User.all.order("profile_name ASC")
  end
  
  def show
    @user = User.find(params[:id])
    @statuses = Status.where("user_id = ?", @user.id).order("created_at DESC")
    @tagged_statuses = Status.tagged_with(@user.profile_name)
  end
end
