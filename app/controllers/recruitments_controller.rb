class RecruitmentsController < ApplicationController
  before_action :move_to_index, except: [:index]
  before_action :authenticate_user!, except: [:index]

  def index
    @groups = Group.includes(:recruitments).order('created_at DESC')
  end

end
