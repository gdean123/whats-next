class ExperiencesController < ApplicationController
  def show
    experience = Experience.find_by_id params[:id]
    render :json => experience
  end

  def create
    experience = Experience.create(tagline: params[:tagline])
    render :json=>{:id=> experience.id}
  end
end
