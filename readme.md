= Roulette

This is a rails 4.2.5 application that simulates a game of roulette.

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

== Installation

Clone the repo

  `git clone ...`

Run the setup script

  `bin/setup`

Start foreman

  `foreman start`

Note that it takes three-minutes for the first game to run. Another game runs
automatically every three-minutes afterwards thereon.

