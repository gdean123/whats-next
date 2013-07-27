require 'spec_helper'

def get_group(group)
  san_francisco = [37.780213, -122.431008]
  get "/experiences", group: group, near: san_francisco
end

describe "Experiences" do
  before do
    berkeley = {latitude: 37.892466, longitude: -122.267586}
    fremont = {latitude: 37.54866, longitude: -121.987435}
    santa_cruz = {latitude: 36.975541, longitude: -122.032555}
    los_angeles = {latitude: 34.044694, longitude: -118.233705}

    @berkeley_experience = FactoryGirl.create(:experience, {tagline: "Berkeley experience"}.merge(berkeley))
    @los_angeles_experience = FactoryGirl.create(:experience, {tagline: "Los Angeles experience"}.merge(los_angeles))
    @santa_cruz_experience = FactoryGirl.create(:experience, {tagline: "Santa Cruz experience"}.merge(santa_cruz))
    @fremont_experience = FactoryGirl.create(:experience, {tagline: "Fremont experience"}.merge(fremont))
  end

  it "renders an experience" do
    get "/experiences/#{@berkeley_experience.id}"
    result = JSON.parse(response.body)
    result["tagline"].should == @berkeley_experience.tagline
  end

  it "creates an experience and renders the id" do
    post "/experiences", {
        tagline: @berkeley_experience.tagline,
        latitude: @berkeley_experience.latitude,
        longitude: @berkeley_experience.longitude }

    Experience.last.tagline.should == @berkeley_experience.tagline
    Experience.last.latitude.should == @berkeley_experience.latitude
    Experience.last.longitude.should == @berkeley_experience.longitude

    result = JSON.parse(response.body)
    result["id"].should == Experience.last.id
  end

  it "returns closest 3 experiences for page 1" do
    get_group(1)

    result = JSON.parse(response.body)
    result.count.should == 3

    result.first["tagline"].should == @berkeley_experience.tagline
    result.second["tagline"].should == @fremont_experience.tagline
    result.third["tagline"].should == @santa_cruz_experience.tagline
  end

  it "returns the 4th closest experience for page 2" do
    get_group(2)

    result = JSON.parse(response.body)
    result.count.should == 1
    result.first["tagline"].should == @los_angeles_experience.tagline
  end

  it "returns no experience for a page past the end" do
    get_group(3)

    result = JSON.parse(response.body)
    result.count.should == 0
  end

  it "deletes an experience" do
    experience = FactoryGirl.create(:experience)
    expect {
      delete "/experiences/#{experience.id}"
    }.to change(Experience, :count).by(-1)
  end

  it "generates the right url" do
    experience = FactoryGirl.create(:experience, image: "mural.png")
    get "/experiences/#{experience.id}"
    result = JSON.parse(response.body)
    result["image"].should == "http://localhost:3000/images/mural.png"
  end
end