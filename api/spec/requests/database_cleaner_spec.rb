require 'spec_helper'

describe "DatabaseCleaner" do

  before do
    FactoryGirl.create(:experience)
  end

  it "cleans database" do
    delete "/clean_database"
    Experience.count.should == 0
    response.body.should be_empty
  end

end