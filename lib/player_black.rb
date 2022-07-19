# frozen_string_literal: true

require_relative 'chess_pieces'

class PlayerBlack
  include ChessPieces

  def initialize
    @player_color = "white"
    @player_pieces = [BLACK_PAWN, BLACK_ROOK, BLACK_KNIGHT,
                      BLACK_BISHOP, BLACK_QUEEN, BLACK_KING]
  end
end