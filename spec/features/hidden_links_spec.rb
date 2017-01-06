require "rails_helper"

RSpec.feature "Users can see the appropriate links"do

  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }

  context "Anonymous users" do
    scenario "cannot see the new project link" do
      visit "/"
      expect(page).to_not have_link "New Project"
    end

    scenario "cannot see the delete project link" do
      visit project_path(project)
      expect(page).to_not have_link "Delete Project"
    end
  end

  context "Authenticated users" do
    before { login_as(user) }

    scenario "cannot see the new project link" do
      visit "/"
      expect(page).to_not have_link "New Project"
    end

    scenario "cannot see the delete project link" do
      visit project_path(project)
      expect(page).to_not have_link "Delete Project"
    end
  end

  context "Admin user" do
    before { login_as(admin) }

    scenario "can see the new project link" do
      visit "/"
      expect(page).to have_link "New Project"
    end

    scenario "can see the delete project link" do
      visit project_path(project)
      expect(page).to have_link "Delete Project"
    end
  end

end
