require "rails_helper"

feature "User visits players list" do
  scenario "successfully" do
    Player.create(name: "Darth Vader")

    visit players_path

    expect(page).to have_content("Darth Vader")
    expect(page).to have_content("$1,000")
  end
end
