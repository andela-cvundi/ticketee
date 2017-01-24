require 'rails_helper'

RSpec.feature "Users can create tickets" do

  let!(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user)
    project = FactoryGirl.create(:project, name: "Internet explorer")
    assign_role!(user, :editor, project)
    visit project_path(project)
    click_link "New Ticket"
  end

  scenario "With valid attributes" do
    fill_in "Name", with: "First ticket"
    fill_in "Description", with: "This is the first ticket we are creating today"
    attach_file "File #1", "spec/fixtures/speed.txt"
    click_button "Create Ticket"
    expect(page).to have_content "Ticket was created successfully"
    within ("#ticket") do
      expect(page).to have_content "Author: #{user.email}"
    end

    within ("#ticket .attachments") do
      expect(page).to have_content "speed.txt"
    end
  end

  scenario "persisting file uploads across form displays" do
    attach_file "File #1", "spec/fixtures/speed.txt"
    click_button "Create Ticket"

    fill_in "Name", with: "Add documentation for blink tag"
    fill_in "Description", with: "The blink tag has a speed attribute"
    click_button "Create Ticket"

    within("#ticket .attachments") do
      expect(page).to have_content "speed.txt"
    end

  end

  scenario "with multiple uploads" do
    fill_in "Name", with: "First ticket"
    fill_in "Description", with: "This is the first ticket we are creating today"

    attach_file "File #1", Rails.root.join("spec/fixtures/speed.txt")
    attach_file "File #2", Rails.root.join("spec/fixtures/spin.txt")
    attach_file "File #3", Rails.root.join("spec/fixtures/gradient.txt")

    click_button "Create Ticket"

    expect(page).to have_content "Ticket was created successfully"

    within("#ticket .attachments") do
      expect(page).to have_content "speed.txt"
      expect(page).to have_content "spin.txt"
      expect(page).to have_content "gradient.txt"
    end

  end



  scenario "With invalid attributes" do
    click_button "Create Ticket"
    expect(page).to have_content "Ticket has not been created"
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario "With invalid description" do
    fill_in "Name", with: "Title for I am legend"
    fill_in "Description", with: "I am"
    click_button "Create Ticket"
    expect(page).to have_content "Description is too short"
  end
end
