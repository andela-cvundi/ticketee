require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "Handles a missing record correctly" do
      get :show, params: { id: "Not here" }
      expect(response).to redirect_to(projects_path)

      message = "The project you are looking for could not be found"
      expect(flash[:alert]).to eq message
    end
  end

end
