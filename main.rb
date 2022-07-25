# frozen_string_literal: true

require "./lib/board"
require "./lib/player_white"
require "./lib/player_black"
require "./lib/game"
require "./lib/square_pieces"
require "./lib/pieces/pawn"
require "./lib/chess_pieces" 

include ChessPieces

board = Board.new
board.generate_board
board.display_board

player_white = PlayerWhite.new
player_black = PlayerBlack.new

game = Game.new

while true 
  # player white turn
  available_moves = false
  until available_moves
    confirmed = false
    until confirmed
      flag = false 
      # get player location and verify piece is there
      until flag
        player_choice = game.get_player_location(player_white.player_color)
        player_choice = game.convert_player_location(player_choice)
        flag = game.verify_location_piece(player_white.player_pieces, player_choice, board.chess_board)
        puts "Your piece isn't located there, please try again!" if flag == false
      end

      # display highlighted piece board and confirm player wants to move this piece
      board.display_board(player_choice)
      piece_confirm = game.get_piece_choice_confirm
      confirmed = game.handle_confirm_choice(piece_confirm)

      if confirmed == false
        player_choice = nil 
        board.display_board
        puts "Piece movement aborted. Pick another piece."
      end
    end

    # generate all possible moves a piece can make
    piece_to_move = board.chess_board[player_choice[0]][player_choice[1]]
    possible_moves = piece_to_move.generate_moves(player_choice, board.chess_board, piece_to_move.piece_symbol)
    
    # if no possible moves, puts error 
    if possible_moves.empty?
      board.display_board
      puts "Piece has no available moves! Please try again."
    else 
      available_moves = true 
    end
  end
  puts "\n"
  board.display_board(player_choice, possible_moves)

  confirmed = false
  until confirmed
    flag = false 
    # get and verify the location plalyer wants to move to
    until flag
      player_end = game.get_end_location(player_white.player_color)
      player_end_hold = player_end.join("")
      player_end = game.convert_player_location(player_end)
      flag = game.verify_possible_move(possible_moves, player_end)
      puts "You can't move there! Try again..." if flag == false
    end

    # confirm player wants to move to their choice
    end_confirm = game.get_end_move_confirm(player_end_hold)
    confirmed = game.handle_confirm_choice(end_confirm)

    if confirmed == false
      player_end = nil 
      board.display_board(player_choice, possible_moves)
      puts "Move choice aborted. Pick another move."
    end
  end

  # update the array representing the chess board to reflect movement
  hold_start = board.chess_board[player_choice[0]][player_choice[1]]
  board.chess_board[player_choice[0]][player_choice[1]] = "   "
  board.chess_board[player_end[0]][player_end[1]] = hold_start

  # def pawn_promotion(chess_board)
  #   for i in 0..7 
  #     unless chess_board[7][i] == "   "
  #       if board.chess_board[7][i].piece_symbol == WHITE_PAWN
  #         w_promoted_queen = Queen.new(WHITE_QUEEN)
  #         board.chess_board[7][i] = w_promoted_queen
  #       else 
  #         next
  #       end
  #     end
  #   end
  # end

  # promote pawn
  for i in 0..7 
    unless chess_board[7][i] == "   "
      if board.chess_board[7][i].piece_symbol == WHITE_PAWN
        w_promoted_queen = Queen.new(WHITE_QUEEN)
        board.chess_board[7][i] = w_promoted_queen
      else 
        next
      end
    end
  end

  board.display_board

  # BLACK TURN CODE COMMENTED OUT TEMPORARILY SO DUPLICATION OF CODE NOT NEEDED TO TEST

  # player black turn
  # confirmed = false
  # until confirmed
  #   flag = false 
  #   until flag
  #     player_choice = game.get_player_location(player_black.player_color)
  #     player_choice = game.convert_player_location(player_choice)
  #     flag = game.verify_location_piece(player_black.player_pieces, player_choice, board.chess_board)
  #     puts "Your piece isn't located there, please try again!" if flag == false
  #   end

  #   board.display_board(player_choice)
  #   piece_confirm = game.get_piece_choice_confirm
  #   confirmed = game.handle_confirm_choice(piece_confirm)

  #   if confirmed == false
  #     player_choice = nil 
  #     board.display_board
  #     puts "Piece movement aborted. Pick another piece."
  #   end
  # end

  # piece_to_move = board.chess_board[player_choice[0]][player_choice[1]]
  # possible_moves = piece_to_move.generate_moves(player_choice, board.chess_board, piece_to_move.piece_symbol)
  # puts "\n"
  # board.display_board(player_choice, possible_moves)

  # confirmed = false
  # until confirmed
  #   flag = false 
  #   until flag
  #     player_end = game.get_end_location(player_black.player_color)
  #     player_end_hold = player_end.join("")
  #     player_end = game.convert_player_location(player_end)
  #     flag = game.verify_possible_move(possible_moves, player_end)
  #     puts "You can't move there! Try again..." if flag == false
  #   end

  #   end_confirm = game.get_end_move_confirm(player_end_hold)
  #   confirmed = game.handle_confirm_choice(end_confirm)

  #   if confirmed == false
  #     player_end = nil 
  #     board.display_board(player_choice, possible_moves)
  #     puts "Move choice aborted. Pick another move."
  #   end
  # end

  # hold_start = board.chess_board[player_choice[0]][player_choice[1]]
  # board.chess_board[player_choice[0]][player_choice[1]] = "   "
  # board.chess_board[player_end[0]][player_end[1]] = hold_start

  # board.display_board
end

