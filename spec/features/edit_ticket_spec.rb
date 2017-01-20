require "rails_helper"

RSpec.feature "Users can edit tickets" do

  let(:project) { FactoryGirl.create(:project) }
  let(:user) { FactoryGirl.create(:user) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }

  before do
    assign_role!(user, :editor, project)
    login_as(user)
    visit project_ticket_path(project, ticket)
    click_link "Edit Ticket"
  end


  scenario "With valid attributes" do
    fill_in "Name", with: "Edited Ticket"
    fill_in "Description", with: "Description for edited ticket"
    click_button "Update Ticket"
    expect(page).to have_content "Ticket was updated successfully"
    within("#ticket h2") do
      expect(page).to have_content "Edited Ticket"
    end
   end

  scenario "With invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Ticket"
    expect(page).to have_content "Error updating ticket"
  end


end
