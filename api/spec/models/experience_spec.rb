require 'spec_helper'

describe Experience do
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

  describe "to_json method" do

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
    it_should_use_correct_base_url_for 'staging', 'http://engage-me-api.herokuapp'
  end
end
