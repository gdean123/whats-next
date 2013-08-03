class ExperiencesController < ApplicationController
  def index
    near_latitude = params[:near_latitude].to_f
    near_longitude = params[:near_longitude].to_f

    render :json => Experience.
        close_to(near_latitude, near_longitude).
        for_group(params[:group])
  end

  def show
    experience = Experience.find_by_id params[:id]

    render :json => experience
  end

  def create
    experience = Experience.create(
        tagline: params[:tagline],
        image_url: params[:image_url],
        latitude: params[:latitude],
        longitude: params[:longitude])

    render :json=>{:id=> experience.id}
  end

  def destroy
    Experience.find(params[:id]).destroy
    head 200
  end
end
