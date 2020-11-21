class HomeController < ApplicationController
  def top
    @user = current_user
  end

  def message
    @user = current_user
    @members = Member.order('created_at DESC').order("RAND()").limit(5)
  end

end
