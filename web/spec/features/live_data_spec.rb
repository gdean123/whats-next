require 'spec_helper'

describe "asking to be a beta tester" do
  it "records me as an interested party" do
    visit '/admin'
    page.should have_content "live_data: 0"

    visit '/live_data'
    page.should have_content 'Collect live data from your audience'

    fill_in 'email', :with => 'user@example.com'
    click_on 'Be a beta tester'

    page.should have_content 'Thank you'

    visit '/admin'
    page.should have_content "live_data: 1"
  end
end