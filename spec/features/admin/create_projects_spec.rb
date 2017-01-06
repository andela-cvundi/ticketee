require 'rails_helper'

RSpec.feature "Users can create new projects" do
  before do
    login_as(FactoryGirl.create(:user, :admin))
    visit "/"
    click_link "New Project"
  end

  scenario "With valid attributes" do
    fill_in "Name", with: "Odein project"
    fill_in "Description", with: "This is the first project"
    click_button "Create Project"

    expect(page).to have_content "Project has been created"

    project = Project.find_by(name: "Odein project")

    expect(page.current_url).to eq project_url(project)

  end

  scenario "With invalid attributes" do
    click_button "Create Project"

    expect(page).to have_content "Project has not been created"

    expect(page).to have_content "Name can't be blank"
  end

end
