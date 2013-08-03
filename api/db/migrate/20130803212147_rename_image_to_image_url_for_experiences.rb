class RenameImageToImageUrlForExperiences < ActiveRecord::Migration
  def change
    rename_column :experiences, :image, :image_url
  end
end
