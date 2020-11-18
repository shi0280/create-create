class Following::FollowRequestsController < ApplicationController
  def create
    followed = User.find(params[:followed_id])
    request = current_user.following_requests.new(following_id: current_user.id, followed_id: followed.id)
    request.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    followed = User.find(params[:followed_id])
    request = current_user.following_requests.find_by(following_id: current_user.id,followed_id: followed.id )
    request.destroy
    redirect_back(fallback_location: root_path)
  end
end
