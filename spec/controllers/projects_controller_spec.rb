require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      expect(controller).to receive(:current_user)
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "Handles a missing record correctly" do
      get :show, params: { id: "Not here" }
      expect(response).to redirect_to(projects_path)

      message = "The project you are looking for could not be found"
      expect(flash[:danger]).to eq message
    end

    it "Handles project not found exceptions well" do
      expect(controller).to receive(:current_user)
      project = FactoryGirl.create(:project)

      get :show, id: project.id

      expect(response).to redirect_to root_path
      message = "You are not allowed to do that"
      expect(flash[:danger]).to eq message

    end

  end

end
