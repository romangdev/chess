# frozen_string_literal: true

require "./lib/board"
require "./lib/player_white"
require "./lib/player_black"

board = Board.new
board.generate_board
board.display_board

player_white = PlayerWhite.new
player_black = PlayerBlack.new



