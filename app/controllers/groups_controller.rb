class GroupsController < ApplicationController  
#   before_action :move_to_index, except: [:index]
#   before_action :authenticate_user!, except: [:index]

  # def index
  #   @groups = Group.includes(:recruitments).order('created_at DESC')
  # end

  def new
  #   follow = current_user.follow_okays.new
  #   @users = User.where(id: follow.followed_id).or(User.where(id: follow.following_id))
    @group = Group.new
    @group.recruitments.new
    @group.users << current_user
  end

  def create
    @group = Group.new(recruitment_params)
    if @group.save
      redirect_to root_path, notice:"投稿完了しました。"
    else
      flash.now[:alert] = "投稿失敗しました。"
      render :new
    end
  end

  # def update
  #   @group = Group.find(params[:id])
  #   if @group.update(recruitments_params)
  #     redirect_to root_path, notice:"募集情報が変更されました。"
  #   else
  #     render :edit
  #     flash.now[:alert] = "編集に失敗しました。"
  #   end
  # end

  # def destroy
  #   @group = Group.find(params[:id])
  #   @group.destroy
  #   redirect_to root_path, notice:"募集情報が削除されました。"
  # end

  private
  
  def recruitment_params
    params.require(:group).permit(:name, user_ids: [], recruitments_attributes: [:title, :image, :adress, :description])
  end

end
