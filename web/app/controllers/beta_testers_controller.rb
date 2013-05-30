class BetaTestersController < ApplicationController
  def create
    BetaTester.create(:email => params[:email],
                      :application => params[:application])
  end
end