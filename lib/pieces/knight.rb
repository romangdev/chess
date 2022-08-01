# frozen_string_literal: true

require './lib/chess_pieces'

class Knight
  attr_reader :piece_symbol

  include ChessPieces

  WHITE_PIECES = [WHITE_PAWN,
                  WHITE_ROOK,
                  WHITE_KNIGHT,
                  WHITE_BISHOP,
                  WHITE_QUEEN,
                  WHITE_KING].freeze

  BLACK_PIECES = [BLACK_PAWN,
                  BLACK_ROOK,
                  BLACK_KNIGHT,
                  BLACK_BISHOP,
                  BLACK_QUEEN,
                  BLACK_KING].freeze

  def initialize(piece_symbol)
    @piece_symbol = piece_symbol
  end

  def generate_moves(current_location, chess_board, knight_color)
    moves = []
    possible_moves = []

    moves << [current_location[0] + 2, current_location[1] + 1] << [current_location[0] + 2, current_location[1] - 1] <<
      [current_location[0] - 2,
       current_location[1] + 1] << [current_location[0] - 2,
                                    current_location[1] - 1] << [current_location[0] + 1, current_location[1] + 2] <<
      [current_location[0] - 1,
       current_location[1] + 2] << [current_location[0] - 1,
                                    current_location[1] - 2] << [current_location[0] + 1, current_location[1] - 2]

    (0...moves.length).each do |i|
      moves[i] = 'nil' if moves[i][0].negative? || moves[i][1].negative? ||
                          moves[i][0] > 7 || moves[i][1] > 7
    end

    moves.delete('nil')

    if knight_color == WHITE_KNIGHT
      moves.each do |move|
        if chess_board[move[0]][move[1]] != '   ' && (WHITE_PIECES.include? chess_board[move[0]][move[1]].piece_symbol)
          move = 'nil'
        end
        possible_moves << move
      end
    else
      moves.each do |move|
        if chess_board[move[0]][move[1]] != '   ' && (BLACK_PIECES.include? chess_board[move[0]][move[1]].piece_symbol)
          move = 'nil'
        end
        possible_moves << move
      end
    end

    possible_moves.delete('nil')

    possible_moves
  end
end
