class Experience < ActiveRecord::Base
  geocoded_by :address

  def self.for_group(group)
    page(group).per(3)
  end

  def self.close_to(latitude, longitude)
    max_distance = 1000
    self.near([latitude, longitude], max_distance, order: "distance, created_at DESC")
  end

  def as_json(options={})
    {
        :image_url => self.image_url,
        :tagline => self.tagline,
        :latitude => self.latitude,
        :longitude => self.longitude
    }
  end
end
