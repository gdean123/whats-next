require 'spec_helper'

describe "Experiences" do
  before do
    @experience = FactoryGirl.create(:experience, tagline: "Run the Lyon Street steps")
  end

  it "renders an experience" do
    get "/experiences/#{@experience.id}"
    result = JSON.parse(response.body)
    result["tagline"].should == @experience.tagline
  end

  it "creates an experience" do
      lambda {
        post "/experiences", { tagline: @experience.tagline }
      }.should change(Experience, :count).by(1)
  end
end