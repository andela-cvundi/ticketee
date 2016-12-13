require 'rails_helper'

RSpec.feature "Users can create new projects" do
  scenario "With valid attributes" do
    visit "/"
    click_link "New Project"
    fill_in "Name", with: "Odein project"
    fill_in "Description", with: "This is the first project"
    click_button "Create Project"

    expect(page).to have_content "Project has been created"

    project = Project.find_by(name: "Odein project")

    expect(page.current_url).to eq project_url(project)

    title = "Projects - Ticketee"
    expect(page).to have_title title
  end
end
