class ExperiencesController < ApplicationController
  def index
    render :json => Experience.paginate(:page => params[:group], :per_page => 3)
  end

  def show
    experience = Experience.find_by_id params[:id]

    render :json => experience
  end

  def create
    experience = Experience.create(
        tagline: params[:tagline],
        image: params[:image],
        latitude: params[:latitude],
        longitude: params[:longitude])

    render :json=>{:id=> experience.id}
  end

  def destroy
    Experience.find(params[:id]).destroy
    head 200
  end
end
