class RecruitmentsController < ApplicationController
  before_action :move_to_index, except: [:index]
  before_action :authenticate_user!, except: [:index]

  def index
    # @groups = Group.includes(:recruitments).order('created_at DESC')
    @q = Group.includes(:recruitments).order('created_at DESC').ransack(params[:q])
    @groups = @q.result(distinct: true)
    @count = @q.result.count
  end

end
