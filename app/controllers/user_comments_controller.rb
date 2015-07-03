class UserCommentsController < InheritedResources::Base
  def create
  	@user_comment = current_user.user_comments.build(params[:user_comment])
  	if @user_comment.save
  		redirect_to @user_comment.status, :notice => "Comment was successfully created."
  	else
  		redirect_to @user_comment.status, :notice => "Error creating comment : #{@user_comment.errors}."	
  	end
  end

  def edit
  	@user_comment = UserComment.find(params[:id])
  	@status = @user_comment.status
  end

  def update
  	@user_comment = UserComment.find(params[:id])
  	@status = @user_comment.status
	if @user_comment.update(params[:user_comment])
  		redirect_to @status, :notice => "Comment was successfully updated."
  	else
  		redirect_to @status, :notice => "Error creating comment : #{@user_comment.errors}."	
    end
  end

  def destroy
  	@user_comment = UserComment.find(params[:id])
  	@status = @user_comment.status
  	@user_comment.destroy
  	redirect_to @status, :notice => "Comment was successfully destroyed."
  end
end

