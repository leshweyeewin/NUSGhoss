class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @statuses = Status.where("user_id = ?", current_user.id).order("created_at DESC");
  end
end
