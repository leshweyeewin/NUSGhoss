class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @statuses = Status.where("user_id = ?", current_user.id).order("created_at DESC")
    @tagged_statuses = Status.tagged_with(current_user.profile_name)
  end
end
