# chess (work in progress)

A command line based game of chess! (2 human players)

![Screen Shot 2022-07-31 at 5 24 18 PM](https://user-images.githubusercontent.com/74276666/182045961-ca25e4b8-0d4e-4d26-9ec7-25547757e51c.png)

**You can play a LIVE version of chess here:** (coming soon)

# Known issues / bugs
- **Checkmate Bug:** Very specific situation where whenever a king is in check, AND it cannot move itself out of check, AND there is no player piece that can capture the opposing player's piece putting the king in check, checkmate will be called. Therefore, this is called incorrectly in situations where an opposing player's rook, bishop, or queen puts the king in check AND the king cannot move, BUT the player could move his/her own piece in front of the check path. 

- **Disappearing Pieces:** In some situations when one player's piece puts the opposing player's king in check while at the same time capturing one of the opposing player's pieces, that player's piece will disappear in the following player's turn. 

- **Spaghetti Code:** As the project moved on, it became less and less organized. Part of this was done purposefully (further explanation in "optimizations" section. 

# Features to add
- **Check for Stalemate:** By the rules, this is a really easy one to implement. However, my code is currently poorly structured in a way that makes this quite difficult... hence why it's not been added at this point.

- **En Passent (In Passing)**

- **Save Feature**

# How It's Made:
Tech used: Ruby, RSpec

This application was created using Ruby and RSpec. Files are broken up mainly into 2 folders, "lib" and "spec". Lib holds the majority of the code in different classes. Variious classes were created for each player, the board, the game, all chess_pieces, and more. With the lib folder is another directory, "pieces" which includes files for each individual class piece and their specific attributes. The spec folder contains unit tests for each relevant class file to ensure the code is working properly. Additionally, I have a main.rb file in the root directory which acts as the actual code to run chess. 

The game is meant for 2 human players. I have no plans on adding AI. Players go back and forth taking turns trying to checkmate one another. 

# Optimizations
This project was much, much larger than I anticipated. Chess is quite deceptive in that, despite some moderately complex rules, it seems quite simple to create. And while the individual problems that make up chess aren't necessarily difficult, it's extremely time consuming. Despite being 80% - 85% finished with chess, I estimate that the remaining 15% will take almost twice as long to finish off. 

I began this to practice writing unit tests and OOP principles, as well as clean code "ironically enough." After the first week or so of keeping things very organizing and utilizing TDD, I realized at that rate it was going to take possibly 2 - 3 months to finish. So after learning tons about clean code and TDD, I stopped practicing those techniques in favor of speed (just finishing the game as quickly as possible) which lead to some very messy code. I was ok with this, as I do not plan on this being a showcase piece (or an app for anyone to seriously use), or having other devs see it... was really just meant for practice. However, it got to the point where I've coded myself into a corner, and am getting diminishing returns. So I'm moving on for now and may come back eventually to continue working on this. 

To keep it simple, if I had more time I would fix the listed bugs above and add in the features I listed as well. 

# Lessons Learned:
This project was crucial in practicing TDD, clean code, OOP principles, and just working on organizing a program of much larger scale. With something with rules as complex as chess's, keeping everything organized and utilizing unit tests was crucial to ensure the program works. 

However, after a week or 2 of practicing these principles, I made the decision to throw them aside to quickly finish the project, as I did not intend to spend months on a learning experience (weighing the cost/benefit of moving on, and deciding it's best to move on). However, the messy code made it more and more difficult to continue, and it's gotten to the point where even minor changes may break something. At this point, I've not only learned even more of a lesson about the importance of clean code and tests, but I've also learned a lesson on estimating the size of projects. 

As previously mentioned, I did not intend to perfect chess or even necessarily make a 100% complete chess program with all features. I intended to practice some things I've learned on a larger project. At this point, I feel like I've gotten what I wanted out of chess and learned valuable lessons. And rather than spending another month or 2 rewriting the code, heavily refactoring, going back and adding tests, fixing all bugs, and adding in the rest of the features, I'm make a personal learning decision to move on from this. 

It's a difficult decision, as I always try to complete everything I begin. But on this journey, I'm realizing being a completionist can sometimes be a detriment to one's learning in many cases. So instead, I'm going to move on and have an extra month or 2 studying up on Rails and databases :) Looking forward to it!
