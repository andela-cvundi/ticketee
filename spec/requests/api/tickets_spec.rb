require "rails_helper"

RSpec.describe "Tickets API" do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:state) { FactoryGirl.create(:state, name: "open") }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, state: state, user: user) }


  before do
    assign_role!(user, :manager, project)
    user.generate_api_key
  end

  context "as an authenticated user" do
    let(:headers) do
      { "HTTP_AUTHORIZATION" => "Token token=#{user.api_key}" }
    end

    it "retrieves a tickets information" do
      get api_project_ticket_path(project, ticket, format: :json),
        {}, headers
      expect(response.status).to eq 200

      json = TicketSerializer.new(ticket).to_json
      expect(response.body).to eq json
    end

  end

end
