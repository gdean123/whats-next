require 'spec_helper'

describe "asking to be a beta tester" do
  it "records me as an interested party" do
    BetaTester.find_by_email('user@example.com').should be_nil

    visit '/'
    page.should have_content 'Collect live data from your audience'

    fill_in 'email', :with => 'user@example.com'
    click_on 'Be a beta tester'

    page.should have_content 'Thank you'
    BetaTester.find_by_email('user@example.com').should_not be_nil
  end
end