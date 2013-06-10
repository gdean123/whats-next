class ExperienceController < ApplicationController
  def index
  end

  def show
    experience = Experience.find_by_id params[:id]

    respond_to do |format|
      format.json { render :json => experience }
    end
  end

  def create
    experience = Experience.create :tagline => params[:experience][:tagline]

    respond_to do |format|
      format.json {render :json=>{:id=> experience.id}}
    end
  end

  def update

  end
end
