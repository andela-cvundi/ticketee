require 'rails_helper'

RSpec.feature "Users can delete projects" do

  before do
    login_as(FactoryGirl.create(:user, :admin))
  end

  scenario "Successfully" do
    project = FactoryGirl.create(:project, name: "Sublime Text")
    visit project_url(project)
    click_link "Delete Project"
    expect(page).to have_content "Project was deleted"
    expect(page.current_url).to eq projects_url
    expect(page).to have_no_content "Sublime Text"
  end
end
