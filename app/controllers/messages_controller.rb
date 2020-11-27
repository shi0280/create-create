class MessagesController < ApplicationController
  before_action :set_group

  def index
    @user = current_user
    @members = Member.order('created_at DESC')
    @message = Message.new
    @messages = @member.messages.includes(:user)
  end

  def create
    @message = @member.messages.new(message_params)
    if @message.save
      redirect_to member_messages_path(@member), notice: 'メッセージが送信されました'
    else
      @messages = @member.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to  member_messages_path(@member.id)
  end

  private

  def message_params
    params.require(:message).permit(:message, :image).merge(user_id: current_user.id)
  end

  def set_group
    @member = Member.find(params[:member_id])
  end
end
