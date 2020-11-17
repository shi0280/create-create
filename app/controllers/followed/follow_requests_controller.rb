class Followed::FollowRequestsController < ApplicationController
  def index
    @requests = current_user.follow_requests.all
    @user = User.find(params[:followed_id])
  end

  def allow
    request = FollowRequest.find(params[:id])
    following = User.find_by(id:request.following_id)
    follow = current_user.follow_okays.new(followed_id:current_user.id, following_id: following.id)
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
