# frozen_string_literal: true
require "./lib/chess_pieces"

class King
  attr_reader :piece_symbol

  include ChessPieces

  def initialize(piece_symbol)
    @first_move_made = false
    @piece_symbol = piece_symbol
  end

  def generate_moves(current_location, chess_board, king_color)
    moves = []
    possible_moves = []

    puts current_location
    moves << [current_location[0] + 1, current_location[1]] <<
            [current_location[0] + 1, current_location[1] + 1] <<
            [current_location[0] + 1, current_location[1] - 1] <<
            [current_location[0] - 1, current_location[1]] <<
            [current_location[0] - 1, current_location[1] + 1] <<
            [current_location[0] - 1, current_location[1] - 1] <<
            [current_location[0], current_location[1] + 1] <<
            [current_location[0], current_location[1] - 1] 

    print moves

    if king_color == WHITE_KING
      moves.each do |move|
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
      puts "black"
    end

    possible_moves.delete("nil")

    possible_moves
  end

  private 
end