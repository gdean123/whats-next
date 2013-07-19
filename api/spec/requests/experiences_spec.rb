require 'spec_helper'

describe "Experiences" do
  before do
    @first_experience = FactoryGirl.create(:experience, tagline: "Run the Lyon Street steps")
    @second_experience = FactoryGirl.create(:experience, tagline: "Check out a mural in the mission")
    @third_experience = FactoryGirl.create(:experience, tagline: "Watch the sunset on the Dumbarton bridge")
    @fourth_experience = FactoryGirl.create(:experience, tagline: "Visit the Rengstorff House")
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

  it "returns first 3 experiences for page 1" do
    get "/experiences", group: 1
    result = JSON.parse(response.body)
    result.count.should == 3
    result.first["tagline"].should == @first_experience.tagline
    result.second["tagline"].should == @second_experience.tagline
    result.third["tagline"].should == @third_experience.tagline
  end

  it "returns the 4th experience for page 2" do
    get "/experiences", group: 2
    result = JSON.parse(response.body)
    result.count.should == 1
    result.first["tagline"].should == @fourth_experience.tagline
  end

  it "returns no experience for a page past the end" do
    get "/experiences", group: 3
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