require 'spec_helper'

describe Experience do
  it "can be created" do
     lambda {
       FactoryGirl.create(:lyon_experience)
     }.should change(Experience, :count).by(1)
  end
end
