require 'rails_helper'

RSpec.feature "Users can create new projects" do
  scenario "With valid attributes" do
    visit "/"
    click_link "New Project"
    fill_in "Name", with: "Odein project"
    fill_in "Description", with: "This is the first project"
    click_button "Create Project"

    expect(page).to have_content "Project has been created"
  end
end
