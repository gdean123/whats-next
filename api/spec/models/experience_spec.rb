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
end
