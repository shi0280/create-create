class HomeController < ApplicationController
  def top
    @user = current_user
  end

  def message
    @user = current_user
  end

  def ivent
    @user = current_user
  end
end
