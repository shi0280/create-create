class HomeController < ApplicationController
  def top
    @user = current_user
  end

  def message
    @user = current_user
    @member = Member.new
    @members = @user.members.order('created_at DESC')
  end

end
