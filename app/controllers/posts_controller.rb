class PostsController < ApplicationController

  def create
    @post = Post.create(post_params)
    redirect_to user_path(@post.user_id), notice: '投稿が送信されました'
  end

  private

  def post_params
    params.require(:post).permit(:title, :image).merge(user_id: current_user.id)
  end

end
