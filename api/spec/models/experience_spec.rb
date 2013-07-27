require 'spec_helper'

describe Experience do
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

  describe "should have a tagline attribute" do
    it {should respond_to(:tagline)}
  end

  describe "should have a image attribute" do
    it {should respond_to(:image)}
  end

  describe "should have a latitude attribute" do
    it {should respond_to(:latitude)}
  end

  describe "should have a longitude attribute" do
    it {should respond_to(:longitude)}
  end

  it "can be created" do
     lambda {
       FactoryGirl.create(:experience)
     }.should change(Experience, :count).by(1)
  end

  describe "to_json" do
    def self.it_should_use_correct_base_url_for(environment, base_url)
      it "should use correct base url for #{environment} environment" do
        set_environment environment
        experience = FactoryGirl.create(:experience, image: "mural.png")
        experience_attributes = JSON.parse(experience.to_json)
        experience_attributes['image'].should == "#{base_url}/images/mural.png"
      end
    end

    it_should_use_correct_base_url_for 'test', 'http://localhost:3000'
    it_should_use_correct_base_url_for 'development', 'http://localhost:3000'
    it_should_use_correct_base_url_for 'integration', 'http://localhost:3001'
    it_should_use_correct_base_url_for 'staging', 'http://engage-me-api-staging.herokuapp.com'
    it_should_use_correct_base_url_for 'production', 'http://engage-me-api.herokuapp.com'
  end

  it "returns the experiences associated with the given group" do
    second_group = Experience.for_group(2)

    second_group.count.should == 1
    second_group.first.should == @fremont_experience
  end

  it "orders the experiences by proximity" do
    san_francisco = [37.780213, -122.431008]
    Experience.close_to(san_francisco).should == [@berkeley_experience, @fremont_experience,
                                              @santa_cruz_experience, @los_angeles_experience]
  end
end
