# frozen_string_literal: true

require "./lib/board"
require "./lib/player_white"
require "./lib/player_black"
require "./lib/game"

board = Board.new
board.generate_board
board.display_board

player_white = PlayerWhite.new
player_black = PlayerBlack.new

game = Game.new

# player white turn
flag = false 
until flag
  player_choice = game.get_player_location
  player_choice = game.convert_player_location(player_choice)
  flag = game.verify_location_piece(player_white.player_pieces, player_choice, board.chess_board)
  puts "Your piece isn't located there, please try again!" if flag == false
end



