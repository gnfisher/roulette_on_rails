require "rails_helper"

feature "User adds player" do
  scenario "successfully" do
    visit new_player_path

    fill_in "Name", with: "Darth Vader"
    click_button "Save"

    expect(page).to have_content("Player successfully added.")
    expect(page).to have_content("Darth Vader ($10,000)")
  end
end
