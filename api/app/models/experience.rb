class Experience < ActiveRecord::Base

  #override the as_json method
  def as_json(options={})
    {
        :image => base_url + "/images/#{self.image}",
        :tagline => self.tagline,
        :latitude => self.latitude,
        :longitude => self.longitude
    }
  end

  private
  def base_url
    if Rails.env.staging?
      "http://engage-me-api-staging.herokuapp.com"
    elsif Rails.env.production?
      "http://engage-me-api.herokuapp.com"
    elsif Rails.env.integration?
      "http://localhost:3001"
    else
      "http://localhost:3000"
    end
  end
end
