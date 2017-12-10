class WagersController < ApplicationController
  def index
    @wagers = WagersSortedByRoundQuery.new(page).run
  end

  private

  def page
    params[:page] || 0
  end
end
