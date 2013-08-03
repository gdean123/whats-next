require 'spec_helper'

def get_group(group)
  san_francisco_latitude = 37.780213
  san_francisco_longitude = -122.431008

  get "/experiences", group: group,
      near_latitude: san_francisco_latitude,
      near_longitude: san_francisco_longitude
end

def create_experiences
  @berkeley_experience = FactoryGirl.create(:experience, {tagline: "Berkeley experience", image_url:"http://www.berkeley.com"}.merge(berkeley))
  @los_angeles_experience = FactoryGirl.create(:experience, {tagline: "Los Angeles experience", image_url:"http://www.la.com"}.merge(los_angeles))
  @santa_cruz_experience = FactoryGirl.create(:experience, {tagline: "Santa Cruz experience", image_url:"http://www.santacruz.com"}.merge(santa_cruz))
  @fremont_experience = FactoryGirl.create(:experience, {tagline: "Fremont experience", image_url:"http://www.fremont.com"}.merge(fremont))
end

describe "Experiences" do
  let(:berkeley) { {latitude: 37.892466, longitude: -122.267586} }
  let(:fremont) { {latitude: 37.54866, longitude: -121.987435} }
  let(:santa_cruz) { {latitude: 36.975541, longitude: -122.032555} }
  let(:los_angeles) { {latitude: 34.044694, longitude: -118.233705} }

  it "renders an experience" do
    create_experiences
    get "/experiences/#{@berkeley_experience.id}"
    result = JSON.parse(response.body)
    result["tagline"].should == @berkeley_experience.tagline
    result["latitude"].should == @berkeley_experience.latitude
    result["longitude"].should == @berkeley_experience.longitude
    result["image_url"].should == @berkeley_experience.image_url
  end

  it "creates an experience and renders the id" do
    post "/experiences", {
        tagline: "A new experience",
        latitude: 123, longitude: 456 }

    Experience.last.tagline.should == "A new experience"
    Experience.last.latitude.should == 123
    Experience.last.longitude.should == 456

    result = JSON.parse(response.body)
    result["id"].should == Experience.last.id
  end

  it "returns closest 3 experiences for page 1" do
    create_experiences
    get_group(1)

    result = JSON.parse(response.body)
    result.count.should == 3

    result.first["tagline"].should == @berkeley_experience.tagline
    result.second["tagline"].should == @fremont_experience.tagline
    result.third["tagline"].should == @santa_cruz_experience.tagline
  end

  it "returns the 4th closest experience for page 2" do
    create_experiences
    get_group(2)

    result = JSON.parse(response.body)
    result.count.should == 1
    result.first["tagline"].should == @los_angeles_experience.tagline
  end

  it "returns no experience for a page past the end" do
    create_experiences
    get_group(3)

    result = JSON.parse(response.body)
    result.count.should == 0
  end

  it "orders by creation time, showing the newest ones first for a given location" do
    old_berkeley_experience = FactoryGirl.create(:experience, {tagline: "Old experience"}.merge(berkeley))
    new_berkeley_experience = FactoryGirl.create(:experience, {tagline: "New experience"}.merge(berkeley))

    old_berkeley_experience.update_attribute(:created_at, "1999-07-27 22:06:27.310845")
    new_berkeley_experience.update_attribute(:created_at, "2013-07-27 22:06:27.310845")

    get_group(1)

    result = JSON.parse(response.body)
    result.first["tagline"].should == "New experience"
    result.second["tagline"].should == "Old experience"
  end

  it "deletes an experience" do
    experience = FactoryGirl.create(:experience)
    expect {
      delete "/experiences/#{experience.id}"
    }.to change(Experience, :count).by(-1)
  end
end