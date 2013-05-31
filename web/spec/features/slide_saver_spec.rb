require 'spec_helper'

describe "asking to be a beta tester" do
  it "records me as an interested party" do
    visit '/admin'
    page.should have_content "slide_saver: 0"

    visit '/slide_saver'
    page.should have_content 'Preview, review, and save slides'

    fill_in 'email', :with => 'user@example.com'
    click_on 'Be a beta tester'

    page.should have_content 'Thank you'

    visit '/admin'
    page.should have_content "slide_saver: 1"
  end
end