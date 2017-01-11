require 'rails_helper'

RSpec.feature "Users can edit projects" do
  let(:user) { FactoryGirl.create(:user) }

  before do
    project = FactoryGirl.create(:project)
    login_as(user)
    assign_role!(user, :manager, project)

    visit project_url(project)
    click_link "Edit Project"
  end

  scenario "With valid details" do
    fill_in "Name", with: "Edited project"
    click_button "Update Project"

    expect(page).to have_content "Project was updated successfully"
    expect(page).to have_content "Edited project"
  end

  scenario "With invalid details" do
    fill_in "Name", with: ""
    click_button "Update Project"

    expect(page).to have_content "Error updating the project"
  end
end
