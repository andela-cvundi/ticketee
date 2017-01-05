require "rails_helper"

RSpec.feature "Logged in users can sign out" do

  let!(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user)
  end

  scenario "successfully" do
    visit "/"
    click_link "Sign Out"
    expect(page).to have_content "Signed out successfully"
  end

end
