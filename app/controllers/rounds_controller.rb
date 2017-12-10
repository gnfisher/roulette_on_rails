class RoundsController < ApplicationController
  def index
    @rounds = Round.all.includes(:wagers).order(created_at: :desc)
  end
end
