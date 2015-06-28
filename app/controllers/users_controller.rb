class UsersController < ApplicationController
  def index
  	@users = User.all.order("profile_name ASC")
  end
  
  def show
    @user = User.find(params[:id])
    @statuses = Status.where("user_id = ?", @user.id).order("created_at DESC")
    @tagged_statuses = Status.tagged_with(@user.first_name).order("created_at DESC") 
    unless @user.first_name == @user.last_name
    	@tagged_statuses += Status.tagged_with(@user.last_name).order("created_at DESC")
    end
    unless @user.first_name == @user.profile_name || @user.last_name == @user.profile_name
    	@tagged_statuses += Status.tagged_with(@user.profile_name).order("created_at DESC")
    end 
  end
end
