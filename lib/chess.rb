# frozen_string_literal: true

require "./lib/board"
require "./lib/player_white"
require "./lib/player_black"
require "./lib/game"
require "./lib/square_pieces"
require "./lib/pieces/pawn"
require "./lib/chess_pieces" 

class Chess 
  include ChessPieces
  
  # check for pawn promotion possibilities and execute on relevant pawns if so
  def pawn_promotion(board, pawn_color)
    for i in 0..7 
      unless board[7][i] == "   "
        handle_promotion_by_color(board, pawn_color, i) if board[7][i].piece_symbol == pawn_color
      end
    end
  end

  def repick_piece?(confirmed, player_choice, board)
    if confirmed == false
      player_choice = nil 
      board.display_board
      puts "Piece movement aborted. Pick another piece."
    end
  end

  # if piece chosen by player has no possible moves, output message to pick another piece
  def no_piece_moves?(possible_moves, board)
    if possible_moves.empty?
      board.display_board
      puts "Piece has no available moves! Please pick another piece."
    else 
      return true 
    end

    false
  end

  # prompts player to repick their move if they don't confirm their choice
  def repick_move?(confirmed, player_end, board, player_choice, possible_moves)
    if confirmed == false
      player_end = nil 
      board.display_board(player_choice, possible_moves)
      puts "Move choice aborted. Pick another move."
    end
  end

  # update the array representing the chess board to reflect movement
  def update_board_movement(board, player_choice, player_end)
    hold_start = board[player_choice[0]][player_choice[1]]
    board[player_choice[0]][player_choice[1]] = "   "
    board[player_end[0]][player_end[1]] = hold_start
  end

  private 

  def handle_promotion_by_color(board, pawn_color, i)
    if pawn_color == WHITE_PAWN
      w_promoted_queen = Queen.new(WHITE_QUEEN)
      board[7][i] = w_promoted_queen
    else
      b_promoted_queen = Queen.new(BLACK_QUEEN)
      board[7][i] = b_promoted_queen
    end
  end
end

include ChessPieces

board = Board.new
board.generate_board
board.display_board

player_white = PlayerWhite.new
player_black = PlayerBlack.new

game = Game.new
chess = Chess.new

while true 
  # player white turn
  available_moves = false
  until available_moves
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

      chess.repick_piece?(confirmed, player_choice, board)
    end


    piece_to_move = board.chess_board[player_choice[0]][player_choice[1]]
    possible_moves = piece_to_move.generate_moves(player_choice, board.chess_board, piece_to_move.piece_symbol)
    available_moves = chess.no_piece_moves?(possible_moves, board)
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

    end_confirm = game.get_end_move_confirm(player_end_hold)
    confirmed = game.handle_confirm_choice(end_confirm)
    chess.repick_move?(confirmed, player_end, board, player_choice, possible_moves)
  end

  chess.update_board_movement(board.chess_board, player_choice, player_end)
  chess.pawn_promotion(board.chess_board, WHITE_PAWN)
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

