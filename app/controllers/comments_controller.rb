class CommentsController < ApplicationController
  def new
  end

  def create
    @comment = Comment.new
    @comment.user_id = current_user.id
    @comment.content = params[:comment][:content]
    @comment.entry_id = params[:comment][:id]
    if @comment.save
      flash[:success] = t ".commented"
    else
      flash[:danger] = t ".comment_failed"
    end
    redirect_to root_url
  end
end
