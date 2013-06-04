class AdminController < ApplicationController
  def index
    @slide_saver_tester_count = BetaTester.where(application: "slide_saver").count
    @live_data_tester_count = BetaTester.where(application: "live_data").count
    @whats_next_tester_count = BetaTester.where(application: 'whats_next').count
  end
end
