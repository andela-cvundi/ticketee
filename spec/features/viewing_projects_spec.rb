RSpec.feature "Users can view projects" do
  scenario "With project details" do
    project = FactoryGirl.create(:project, name: "Sublime Text")

    visit "/"
    click_link "Sublime Text"
    expect(page.current_url).to eq project_url(project)

  end
end
