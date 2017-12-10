require "rails_helper"

feature "User views round history" do
  scenario "successfully" do
    setup_rounds

    visit rounds_path

    expect(page).to have_content("Darth Vader", count: 3)
    expect(page).to have_content("Luke Skywalker", count: 3)
  end

  def setup_rounds
    vader = Player.create(name: "Darth Vader")
    luke = Player.create(name: "Luke Skywalker")

    3.times do
      RouletteRound.new([vader, luke]).play
    end
  end
end
