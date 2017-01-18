require "rails_helper"

RSpec.feature "Users can see the appropriate links"do

  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }


  context "Non admin users" do

    before do
      login_as(user)
      assign_role!(user, :viewer, project)
    end

    scenario "cannot see the new project link" do
      visit "/"
      expect(page).to_not have_link "New Project"
    end

    scenario "cannot see the delete project link" do
      visit project_path(project)
      expect(page).to_not have_link "Delete Project"
    end

    scenario "cannot see the edit project link" do
      visit project_path(project)
      expect(page).to_not have_link "Edit Project"
    end

    scenario "cannot see the new project link" do
      visit project_path(project)
      expect(page).to_not have_link "New Ticket"
    end

    scenario "cannot see the Edit Ticket link" do
      visit project_ticket_path(project, ticket)
      expect(page).not_to have_link "Edit Ticket"
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

    scenario "can see the edit project link" do
      visit project_path(project)
      expect(page).to have_link "Edit Project"
    end

    scenario "can see the new ticket link" do
      visit project_path(project)
      expect(page).to have_link "New Ticket"
    end

    scenario "can see the Edit Ticket link" do
      visit project_ticket_path(project, ticket)
      expect(page).to have_link "Edit Ticket"
    end

  end

end
