

class UsersController < ApplicationController
  def index
  	@users = User.all.order("profile_name ASC")
  end

  def show
    @user = User.find(params[:id])
    @statuses = Status.where("user_id = ?", @user.id).order("created_at DESC").paginate(:page => params[:page], :per_page => 4);
    @liked_statuses = @user.find_liked_items.paginate(:page => params[:page], :per_page => 4);
    @tagged_statuses = Status.tagged_with(@user.ivle_name).order("created_at DESC")
    unless @user.ivle_name == @user.profile_name
    	@tagged_statuses += Status.tagged_with(@user.profile_name).order("created_at DESC")
    end
    @tagged_statuses = @tagged_statuses.paginate(:page => params[:page], :per_page => 4);
  end
end
