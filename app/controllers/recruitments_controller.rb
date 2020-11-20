class RecruitmentsController < ApplicationController
  before_action :move_to_index, except: [:index]
  before_action :authenticate_user!, except: [:index]

  def index
    @groups = Group.includes(:recruitments).order('created_at DESC')
  end

  def new
    follow = current_user.follow_okays.new
    @users = User.where(id: follow.followed_id).or(User.where(id: follow.following_id))
    @group = Group.new
    @group.recruitments.new
    @group.users << current_user
  end

  def create
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
