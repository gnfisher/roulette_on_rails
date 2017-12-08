require "rails_helper"

feature "User updates player data" do
  scenario "successfully" do
    player = Player.create(name: "Darth Vader")
    visit edit_player_path(player)

    fill_in "Name", with: "Donald Trump"
    fill_in "Money", with: 100_000
    click_button "Save"

    expect(page).to have_content("Player record successfully updated.")
    expect(page).to have_content("Donald Trump ($100,000)")
  end
end
