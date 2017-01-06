require "rails_helper"

RSpec.feature "Admins can archive users" do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin) }

  before do
    login_as(admin)
  end


  scenario "successfully" do
    visit admin_user_path(user)
    click_link "Archive User"
    expect(page).to have_content "User was archived successfully"
    expect(page).not_to have_content user.email
  end

  scenario "cannot archive themselves" do
    visit admin_user_path(admin)
    click_link "Archive User"
    expect(page).to have_content "You cannot archive yourself"
  end

end
