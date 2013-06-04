require 'spec_helper'

describe "asking to be a beta tester" do
  it "records me as an interested party" do
    visit '/admin'
    page.should have_content "whats_next: 0"

    visit '/whats_next'
    page.should have_content 'Find unique experiences near you'

    fill_in 'email', :with => 'user@example.com'
    click_on 'Be a beta tester'

    page.should have_content 'Thank you'

    visit '/admin'
    page.should have_content "whats_next: 1"
  end
end