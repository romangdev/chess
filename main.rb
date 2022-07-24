# frozen_string_literal: true

require "./lib/board"
require "./lib/player_white"
require "./lib/player_black"
require "./lib/game"
require "./lib/square_pieces"
require "./lib/pieces/pawn"

board = Board.new
board.generate_board
board.display_board

player_white = PlayerWhite.new
player_black = PlayerBlack.new

game = Game.new

# player white turn
confirmed = false
until confirmed
  flag = false 
  until flag
    player_choice = game.get_player_location(player_white.player_color)
    player_choice = game.convert_player_location(player_choice)
    flag = game.verify_location_piece(player_white.player_pieces, player_choice, board.chess_board)
    puts "Your piece isn't located there, please try again!" if flag == false
  end

  board.display_board(player_choice)
  piece_confirm = game.get_piece_choice_confirm
  confirmed = game.handle_confirm_choice(piece_confirm)

  if confirmed == false
    player_choice = nil 
    board.display_board
    puts "Piece movement aborted. Pick another piece."
  end
end

piece_to_move = board.chess_board[player_choice[0]][player_choice[1]]
possible_moves = piece_to_move.generate_moves(player_choice, board.chess_board, piece_to_move.piece_symbol)
puts "\n"
board.display_board(player_choice, possible_moves)

confirmed = false
until confirmed
  flag = false 
  until flag
    player_end = game.get_end_location(player_white.player_color)
    player_end = game.convert_player_location(player_end)
    flag = game.verify_possible_move(possible_moves, player_end)
    puts "You can't move there! Try again..." if flag == false
  end

  end_confirm = game.get_end_move_confirm(player_end)
  confirmed = game.handle_confirm_choice(end_confirm)

  if confirmed == false
    player_end = nil 
    # board.display_board
    puts "Move choice aborted. Pick another move."
  end
end

# board.display_board(player_end)




