require "rails_helper"

RSpec.feature "Admins can change user details" do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(admin)
    visit admin_user_path(user)
    click_link "Edit User"
  end

  scenario "normal user" do
    fill_in  "Email", with: "newguy@example.com"
    click_button "Update User"
    expect(page).to have_content "User was updated successfully"
    expect(page).to have_content "newguy@example.com"
    expect(page).to_not have_content user.email
  end

  scenario "toggle admin user" do
    check "Is admin?"
    click_button "Update User"
    expect(page).to have_content "User was updated successfully"
    expect(page).to have_content "#{user.email} (Admin)"
  end
end
