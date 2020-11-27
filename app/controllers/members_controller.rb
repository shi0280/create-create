class MembersController < ApplicationController
  before_action :set_users

  def index
    @user = current_user
    @member = Member.new
    @members = @user.members.order('created_at DESC')
  end

  def new
    @member = Member.new
    @member.users << current_user
  end

  def create
    ids1 = current_user.following_okays.pluck(:followed_id) 
    ids2 = current_user.followed_okays.pluck(:following_id) 
    @users = User.where(id: ids1).or(User.where(id: ids2)).or(User.where(id: current_user))
    @member = Member.new(member_params)
    if @member.save
      redirect_to member_messages_path(@member), notice: 'メンバーを作成しました'
    else
      render :new
      flash.now[:alert] = "登録に失敗しました。"
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to member_messages_path(@member), notice: 'メンバーを更新しました'
    else
      render :edit
      flash.now[:alert] = "編集に失敗しました。"
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to member_messages_path(@member), notice:"メンバーが削除されました。"
  end

  private
  def member_params
    params.require(:member).permit(:name, user_ids: [])
  end

  def set_users
    ids1 = current_user.following_okays.pluck(:followed_id) 
    ids2 = current_user.followed_okays.pluck(:following_id) 
    @users = User.where(id: ids1).or(User.where(id: ids2)).or(User.where(id: current_user))
  end

end
