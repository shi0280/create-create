class RecruitmentsController < ApplicationController
  before_action :move_to_index, except: [:index]
  before_action :authenticate_user!, except: [:index]

  def index
    @recruitments = Recruitment.all
  end

  def new
    @group = Group.new
    @group.recruitments.new
    @group.users << current_user
  end

  def create
    @group = Group.new(recruitment_params)
    if @group.save
      redirect_to root_path, notice:"投稿完了しました。"
    else
      @group.recruitments.new
      flash.now[:alert] = "投稿失敗しました。"
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
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
  
  def product_params
    params.require(:group).permit(
      :name,
      user_ids: [],
      recruitments_attributes: [
                        :title,
                        :image,
                        :adress,
                        :description,
                        :user_id]
    ).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
