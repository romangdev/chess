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
  confirmed = game.handle_confirm_piece_choice(piece_confirm)

  if confirmed == false
    player_choice = nil 
    board.display_board
    puts "Piece movement aborted. Pick another piece."
  end
end

board.pawn_test(player_choice)

piece_to_move = board.chess_board[player_choice[0]][player_choice[1]]
if piece_to_move.is_a? Pawn 
  piece_to_move.generate_moves(player_choice, board.chess_board, piece_to_move.piece_symbol)
elsif piece_to_move.is_a? Rook
  piece_to_move.generate_moves(player_choice, board.chess_board, piece_to_move.piece_symbol)
elsif piece_to_move.is_a? Bishop
  piece_to_move.generate_moves(player_choice, board.chess_board, piece_to_move.piece_symbol)
elsif piece_to_move.is_a? Queen
  piece_to_move.generate_moves(player_choice, board.chess_board, piece_to_move.piece_symbol)
end





