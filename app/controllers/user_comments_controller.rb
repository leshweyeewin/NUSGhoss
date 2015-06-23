class UserCommentsController < InheritedResources::Base

  def create
  	@user_comment = current_user.user_comments.build(params[:user_comment])
  	if @user_comment.save
  		redirect_to @user_comment.status, :notice => "Comment was successfully created."
  	else
  		redirect_to @user_comment.status, :notice => "Error creating comment : #{@user_comment.errors}."	
  	end
  end
end

