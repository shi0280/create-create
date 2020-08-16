class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user 
      redirect_to root_path, alert: 'アクセスできません。'
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(user), notice: "ユーザー情報が更新されました。"
    else
      render :edit
    end
  end

  def search
    @users = User.search(params[:keyword])
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :gender, :adress, :work, :image, :profile, :email)
  end

end
