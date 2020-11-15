class Following::FollowRequestsController < ApplicationController
  def create
    followed = User.find(params[:id])
    request = current_user.follow_requests.new(following_id: current_user.id, followed_id: followed.id )
    request.save
    redirect_back(fallback_location: following_root_path) 
  end

  def destroy
    followed = User.find(params[:id])
    request = current_user.follow_requests.find_by(followed_id: followed.id, following_id: current_user.id)
    request.destroy
    redirect_back(fallback_location: following_root_path) #同じページにリダイレクト。これは任意のページで。
  end
end
