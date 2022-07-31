# chess

A command line based game of chess! (2 human players)

![Screen Shot 2022-07-31 at 5 24 18 PM](https://user-images.githubusercontent.com/74276666/182045961-ca25e4b8-0d4e-4d26-9ec7-25547757e51c.png)

**You can play a LIVE version of chess here:** (coming soon)

# Known issues / bugs
- **Checkmate bug**: Very specific situation where whenever a king is in check, AND it cannot move itself out of check, AND there is no player piece that can capture the opposing player's piece putting the king in check, checkmate will be called. Therefore, this is called incorrectly in situations where an opposing player's rook, bishop, or queen puts the king in check AND the king cannot move, BUT the player could move his/her own piece in front of the check path. 
- **Disappearing pieces** In some situations when one player's piece puts the opposing player's king in check while at the same time capturing one of the opposing player's pieces, that player's piece will disappear in the following player's turn. 

# Features to add

# How It's Made:
Tech used: Ruby, RSpec

This application was created using Ruby and RSpec, with a focus on clean code and organization through OOP principles and utilizing test driven development (TDD). It is composed of 3 classes: a Player class which holds information about individual players, a Board class which generates and holds information about the connect four board, and a Game class which runs various methods to get/place symbols, validate inputs, commence player turns, etc. There's an additional main file that holds a script to run an entire connect four game. 

Furthermore, there are four test files for all 3 classes and the main script file that unit tests usual cases and edge cases for the applicable methods to ensure they work as intended, and allow future work done on this project to refactor without worry about breaking the code.

# Optimizations
With more time given to the project, I'd spend a bit of it trying to improve the UI so that it's a bit more "enticing" than it currently is, even through the command line. Additionally, I'd add in save functionality so that players can quit in the middle of the game, save the game's state, and then load it back up whenever they decide to. Finally, it'd be a fun plus to give players the option to choose from several different symbol choices, rather than just two.


# Lessons Learned:
This project was the first one I've done utilizing TDD, and I learned a TON about it. TDD was extremely difficult to wrap my head around in the week or 2 leading up to connect four. Not just TDD, be even moreso Rspec's DSL syntax. It felt like learning how to program all over again. But after a week and a half or so of going through countless exercises and reviewing the topics explained in different ways over and over again, I finally felt confident enough to create a project from scratch, TDD style. 

I'm finally really understanding the value of TDD, how it leads to cleaner code and helps make future development so much safer and quicker, with the tradeoff of the initial development being longer. As far as I can tell, the trade off seems to be worth it... maybe not so much in a small solo dev project, but for any medium to large project - especially any project with a team - TDD is the way to go. At least, testing in general is always crucial. 
