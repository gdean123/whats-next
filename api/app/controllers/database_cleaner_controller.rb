class DatabaseCleanerController < ApplicationController
  def clean_database
    Experience.destroy_all
    render :json => ""
  end
end