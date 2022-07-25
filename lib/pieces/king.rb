# frozen_string_literal: true
require "./lib/chess_pieces"

class King
  attr_accessor :checked
  attr_reader :piece_symbol

  include ChessPieces

  def initialize(piece_symbol)
    @first_move_made = false
    @piece_symbol = piece_symbol
    @checked = false
  end

  def generate_moves(current_location, chess_board, king_color)
    moves = []
    possible_moves = []

    moves << [current_location[0] + 1, current_location[1]] <<
            [current_location[0] + 1, current_location[1] + 1] <<
            [current_location[0] + 1, current_location[1] - 1] <<
            [current_location[0] - 1, current_location[1]] <<
            [current_location[0] - 1, current_location[1] + 1] <<
            [current_location[0] - 1, current_location[1] - 1] <<
            [current_location[0], current_location[1] + 1] <<
            [current_location[0], current_location[1] - 1] 

    if king_color == WHITE_KING
      moves.each do |move|
        next if move[0].negative? || move[0] > 7 || move[1].negative? || move[1] > 7 

        unless chess_board[move[0]][move[1]] == "   "
          if chess_board[move[0]][move[1]].piece_symbol == WHITE_BISHOP ||
            chess_board[move[0]][move[1]].piece_symbol == WHITE_PAWN ||
            chess_board[move[0]][move[1]].piece_symbol == WHITE_ROOK ||
            chess_board[move[0]][move[1]].piece_symbol == WHITE_KNIGHT||
            chess_board[move[0]][move[1]].piece_symbol == WHITE_QUEEN

            move = "nil"
            possible_moves << move
          end
        end
       possible_moves << move
      end
    else
      moves.each do |move|
        next if move[0].negative? || move[0] > 7 || move[1].negative? || move[1] > 7 

        unless chess_board[move[0]][move[1]] == "   " 
          if chess_board[move[0]][move[1]].piece_symbol == BLACK_BISHOP ||
            chess_board[move[0]][move[1]].piece_symbol == BLACK_PAWN ||
            chess_board[move[0]][move[1]].piece_symbol == BLACK_ROOK ||
            chess_board[move[0]][move[1]].piece_symbol == BLACK_KNIGHT||
            chess_board[move[0]][move[1]].piece_symbol == BLACK_QUEEN

            move = "nil"
            possible_moves << move
          end
        end
        possible_moves << move
      end
    end

    possible_moves.delete("nil")

    print possible_moves
    possible_moves
  end

  private 
end