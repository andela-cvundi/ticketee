require "rails_helper"

RSpec.feature "Users can sign in" do


  let!(:user) { FactoryGirl.create(:user) }

  scenario "successfully" do
    visit "/"
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    expect(page).to have_content "Signed in successfully"
    expect(page).to have_content "Signed in as #{user.email}"
  end

  scenario "unless archived" do
    user.archive

    visit "/"
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    expect(page).to have_content "Your account has been archived"
  end


end
