class GroupsController < ApplicationController  
  before_action :move_to_index, except: [:index]
  before_action :authenticate_user!, except: [:index]
  before_action :set_users, except: [:index]

  def index
    @q = Group.includes(:recruitments).order('created_at DESC').ransack(params[:q])
    @groups = @q.result(distinct: true)
    @count = @q.result.count
  end

  def new
    @group = Group.new
    @group.recruitments.new
    @group.users << current_user
  end

  def create
    @group = Group.new(recruitment_params)
    if @group.save
      redirect_to root_path, notice:"募集情報の投稿が完了しました。"
    else
      flash.now[:alert] = "募集情報の投稿に失敗しました。"
      render :new
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(recruitments_params)
      redirect_to root_path, notice:"募集情報が変更されました。"
    else
      render :edit
      flash.now[:alert] = "編集に失敗しました。"
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to root_path, notice:"募集情報が削除されました。"
  end

  private
  
  def recruitment_params
    params.require(:group).permit(:name, user_ids: [], recruitments_attributes: [:title, :image, :adress, :description])
  end
  
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def set_users
    ids1 = current_user.following_okays.pluck(:followed_id) 
    ids2 = current_user.followed_okays.pluck(:following_id) 
    @users = User.where(id: ids1).or(User.where(id: ids2)).or(User.where(id: current_user))
  end

end
