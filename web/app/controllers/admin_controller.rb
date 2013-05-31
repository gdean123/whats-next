class AdminController < ApplicationController
  def index
    @slide_saver_tester_count = BetaTester.where(application: "slide_saver").count
  end
end
