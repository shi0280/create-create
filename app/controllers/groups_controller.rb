class RecruitmentsController < ApplicationController  
  def index
    @groups = Group.includes(:recruitments).order('created_at DESC')
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
