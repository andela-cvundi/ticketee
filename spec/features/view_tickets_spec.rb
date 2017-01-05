require 'rails_helper'

RSpec.feature "Users can view tickets" do

  before do
    sublime = FactoryGirl.create(:project, name: "sublime")
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:ticket, project: sublime, user: user, name: "first ticket", description: "This is the description for the first ticket")
    ie = FactoryGirl.create(:project, name: "ie")
    FactoryGirl.create(:ticket, project: ie, user: user, name: "ie ticket", description: "This is the description for the ie ticket")

    visit "/"
  end

  scenario "For a given project" do
    click_link "sublime"
    expect(page).to have_content "first ticket"
    expect(page).to_not have_content "ie ticket"

    click_link "first ticket"

    within("#ticket h2") do
      expect(page).to have_content "first ticket"
    end

    expect(page).to have_content "This is the description for the first ticket"

  end

end
