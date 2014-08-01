Burst-Card-Game-App
===================

This is an in-progress iOS app for a strategic, trick-based card game called Burst.  It is fully playable, both with multiple human players and with computer players.  However, currently the AI does not play very well, and I am working on algorithms to make it smarter.  Till then, here is the rudimentary game: it generates graphics, responds to touch events, animates card motion, and understands/incorporates the rules of the game.

The game itself (excluding the menu) consists of one viewController and one model.  The model handles all the thinking -- checking if cards are playable according to the rules of the game, keeping track of score, changing the player whose turn it is, etc.  The viewController focuses on manifesting those changes on the screen.

Again, this is a rudimentary version of the game.  Although it has all the functionings of a good pass-and-play card game, it does not have a smart AI yet.  Therefore, in order to facilitate debugging, the game shows all players cards.  That is, however, easily removable and will be gone in the final game.

Feel free to play around with this game, and if you have any comments or suggestions, please message me, Amal Nanavati, via LinkedIn.  Enjoy!
