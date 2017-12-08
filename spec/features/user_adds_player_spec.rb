require "rails_helper"

feature "User adds player" do
  scenario "successfully" do
    visit new_player_path

    fill_in "Name", with: "Darth Vader"
    fill_in "Money", with: 2_000
    click_button "Save"

    expect(page).to have_content("Player successfully added.")
    expect(page).to have_content("Darth Vader ($2,000)")
  end
end
