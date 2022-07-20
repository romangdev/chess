# frozen_string_literal: true

# require './lib/square_pieces'

class Pawn
  attr_accessor :first_move_made
  attr_reader :piece_symbol

  def initialize(piece_symbol)
    @first_move_made = false
    @piece_symbol = piece_symbol
  end

  def generate_moves(current_location, chess_board = nil) 
    moves = []
    moves = check_first_move(moves, current_location)
    # moves = check_capturable_pieces(moves, current_location, chess_board)
    moves << [current_location[0] + 1, current_location[1]]
    print moves
    moves
  end

  private

  def check_first_move(moves, current_location)
    moves << [current_location[0] + 2, current_location[1]] if self.first_move_made == false 
    moves
  end

  # def check_capturable_pieces(moves, current_location, chess_board)
  #   right_diagonal = chess_board[current_location[0] + 1][current_location[1] + 1]
  #   left_diagonal = chess_board[current_location[0] + 1][current_location[1] - 1]

  #   # if self.piece_symbol == WHITE_PAWN
  #     if right_diagonal != "   " && (right_diagonal.piece_symbol == BLACK_PAWN ||
  #       right_diagonal.piece_symbol == BLACK_ROOK || right_diagonal.piece_symbol == BLACK_KNIGHT ||
  #       right_diagonal.piece_symbol == BLACK_BISHOP || right_diagonal.piece_symbol == BLACK_QUEEN ||
  #       right_diagonal.piece_symbol == BLACK_KING)

  #       moves << [current_location[0] + 1, current_location[1] + 1]
  #     end
  #     if left_diagonal != "   " && (left_diagonal.piece_symbol == BLACK_PAWN ||
  #       left_diagonal.piece_symbol == BLACK_ROOK || left_diagonal.piece_symbol == BLACK_KNIGHT ||
  #       left_diagonal.piece_symbol == BLACK_BISHOP || left_diagonal.piece_symbol == BLACK_QUEEN ||
  #       left_diagonal.piece_symbol == BLACK_KING)

  #       moves << [current_location[0] + 1, current_location[1] - 1]
  #     end
  #   # end

  #   moves
  # end
end