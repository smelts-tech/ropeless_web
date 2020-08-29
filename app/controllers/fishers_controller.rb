class FishersController < ApplicationController
  def show
    @fisher = Fisher.includes(:devices).find(params[:id])
  end
end
