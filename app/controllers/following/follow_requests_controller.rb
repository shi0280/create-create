class Following::FollowRequestsController < ApplicationController
  def create
    followed = User.find(params[:followed_id])
    request = current_user.follow_requests.new(following_id: current_user.id, followed_id: followed.id)
    request.save
  end

  def destroy
    followed = User.find(params[:followed_id])
    request = current_user.follow_requests.find_by(following_id: current_user.id,followed_id: followed.id )
    request.destroy
  end
end
