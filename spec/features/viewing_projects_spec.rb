require "rails_helper"

RSpec.feature "Users can view projects" do
  let(:user)  { FactoryGirl.create(:user) }
  let(:project)  { FactoryGirl.create(:project, name: "Sublime Text") }

  before do
    login_as(user)
    assign_role!(user, :viewer, project)
  end

  scenario "With project details" do
    visit "/"
    click_link "Sublime Text"
    expect(page.current_url).to eq project_url(project)
  end
end
