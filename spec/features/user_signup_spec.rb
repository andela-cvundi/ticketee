require "rails_helper"

RSpec.feature "Users cam sign up" do

  scenario "successfully" do
    visit "/"
    click_link  "Sign Up"
    fill_in "Email", with: "test@example.com"
    fill_in "user_password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    expect(page).to have_content "You have signed up successfully"
  end

end
