# Roulette on Rails

This is a rails 4.2.7.1 application that simulates a game of roulette.

* Players start with $10,000 when created.
* They will bet between 8 and 15 percent of their money each hand if it isn't
  raining in Santiago in the next 7 days.
* They will bet between 4 and 10 percent if it is going to rain.
* They will guess green 2% of the time, red 49% of the time, and black 49% of
  the time.
* The Roulette game determines the color using the same percentages for odds.
* Black/red double the wager.
* Green gives x15 the wager.
* At midnight players get $10,000 added to their purse.

## Installation

Clone the repo: `git clone git@github.com:gnfisher/roulette_on_rails.git`

`cd` into the directory: `cd roulette_on_rails`

Run the setup script: `bin/setup`

Start foreman: `foreman start`

Open `http://localhost:3000` in your browser.

*Note* that it takes three-minutes for the first game to run. Another game runs
automatically every three-minutes afterwards thereon.

## About the code

This project uses:

* RSpec and Capybara for testing
* DelayedJob for background jobs
* DelayedJob Recurring for scheduling recurring tasks
* OpenWeather gem for fetching the weather for the next 7 days.
* Kaminari for paginating

In this project a few basic techniques are employed:

* [WeatherChecker](https://github.com/gnfisher/roulette_on_rails/blob/master/app/models/weather_checker.rb) wraps the OpenWeather API, a pretty basic example of the Adapter pattern.
* [WagersSortedByRoundQuery](https://github.com/gnfisher/roulette_on_rails/blob/master/app/models/wagers_sorted_by_round_query.rb) is an extracted query object. It's pretty basic, too.
* [WagerCalculator](https://github.com/gnfisher/roulette_on_rails/blob/master/app/models/wager_calculator.rb)
  was the result of another refactoring (extract class).
* [RouletteGame](https://github.com/gnfisher/roulette_on_rails/blob/master/app/models/roulette_game.rb)
is the main entry point to the Roulette game. Its a task that includes
DelayedJob Recurring and runs every three minutes. It fetches the current active
players (with money) and passes them to RouletteRound.
* [RouletteRound](https://github.com/gnfisher/roulette_on_rails/blob/master/app/models/roulette_round.rb)
  is the heart of the app. It fetches the weather report, generates a result for
the roulette wheel for the round, and then passes each player to the
PlayerRoundJob with the necessary information to complete there round for each
player.
* [PlayerRound](https://github.com/gnfisher/roulette_on_rails/blob/master/app/models/player_round.rb)
  collaborates with WagerCalculator to determine how much a player will bet and
with RouletteGame to pick a color to wager on. It also collaborates with
RouletteGame to determine the amount of winnings. Finally, it locks the player
record and saves the new wager record with the data and also makes sure to
update the Player record's money with any winnings/losses.

That's the core of it. There's also a NightlyDepositTask that runs a
NighltyDepositJob, adding 10,000 to the balance of each player at 00:01am every
day, as well as the ActiveRecord models for Wager, Player, etc.

I think the app does a decent job of using Object Oriented Design principles to
keep things loosely coupled and easy to reason about.

The entire project was carried out using Discovery Testing techniques.
Essentially, starting with a feature spec and working top down to discover value
objects and collaborator objects, and then writing specs for those. I didn't
write tests for the rake tasks nor for the WeatherChecker class. This was a code
challenge and I had already put in the recommended time and so left those
without an coverage.
 
