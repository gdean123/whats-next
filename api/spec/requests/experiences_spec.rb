require 'spec_helper'

describe "Experiences" do
  before do
    @first_experience = FactoryGirl.create(:experience, tagline: "Run the Lyon Street steps")
    @second_experience = FactoryGirl.create(:experience, tagline: "Check out a mural in the mission")
  end

  it "renders an experience" do
    get "/experiences/#{@first_experience.id}"
    result = JSON.parse(response.body)
    result["tagline"].should == @first_experience.tagline
  end

  it "creates an experience and renders the id" do
    lambda {
      post "/experiences", { tagline: @first_experience.tagline }
    }.should change(Experience, :count).by(1)

    result = JSON.parse(response.body)
    result["id"].should == Experience.last.id
  end

  it "returns all experiences" do
    get "/experiences"
    result = JSON.parse(response.body)
    result.first["tagline"].should == @first_experience.tagline
    result.second["tagline"].should == @second_experience.tagline
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