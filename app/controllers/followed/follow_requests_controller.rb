class Followed::FollowRequestsController < ApplicationController
  def index
    @following_requests = current_user.following_requests.all
    @followed_requests = current_user.followed_requests.all
    @user = User.find(params[:followed_id])
    @following_okays = current_user.following_okays.all
    @followed_okays = current_user.followed_okays.all
  end

  def allow
    request = FollowRequest.find(params[:id])
    following = User.find_by(id:request.following_id)
    follow = current_user.followed_okays.new(followed_id:current_user.id, following_id: following.id)
    follow.save 
    request.destroy 
    redirect_back(fallback_location: root_path)
  end

  def destroy
    request = FollowRequest.find(params[:id])
    request.destroy
    redirect_back(fallback_location: root_path)
  end
end
