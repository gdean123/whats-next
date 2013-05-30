class BetaTestersController < ApplicationController
  def create
    BetaTester.create(:email => params[:email])
  end
end