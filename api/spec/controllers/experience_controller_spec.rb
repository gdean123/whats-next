require 'spec_helper'

describe ExperienceController do

  before do
    @lyon = FactoryGirl.create(:lyon_experience)
  end

  describe "POST create" do
    describe "with valid params" do
      it "should create a new experience" do
        @mural = FactoryGirl.build(:mural_experience)
        lambda {
          post :create, {:format=>'json', :experience => @mural.attributes}
        }.should change(Experience, :count).by(1)
      end
    end
  end

  describe "GET show" do
    it "should return a saved experience" do
      get :show, {:format=>'json', :id=>@lyon.id}
      result = JSON.parse(response.body)
      result[:tagline.to_s].should == @lyon.tagline
    end
  end

end
