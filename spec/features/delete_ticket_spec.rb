require "rails_helper"

RSpec.feature "Users can delete tickets" do

  let(:project) { FactoryGirl.create(:project) }
  let(:user) { FactoryGirl.create(:user) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }


  before do
    visit project_ticket_path(project, ticket)
  end

  scenario "Successfully" do
    click_link "Delete Ticket"
    expect(page).to have_content "Ticket was deleted successfully"
    expect(page.current_url).to eq project_url(project)
  end
end


