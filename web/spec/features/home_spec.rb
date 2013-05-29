require 'spec_helper'

describe "the home page"do
  it "shows a title" do
    visit '/'
    page.should have_content 'Welcome'
  end
end