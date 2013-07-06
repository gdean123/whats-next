class Experience < ActiveRecord::Base

  #override the as_json method
  def as_json(options={})
    prefix = (Rails.env.staging?) ? 'http://engage-me-api.herokuapp' : 'http://localhost:3000'
    {
      :image => prefix + "/images/#{self.image}",
      :tagline => self.tagline,
      :latitude => self.latitude,
      :longitude => self.longitude
    }
  end
end
