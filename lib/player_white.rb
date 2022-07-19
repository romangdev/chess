# frozen_string_literal: true

require_relative 'chess_pieces'

class PlayerWhite
  include ChessPieces

  def initialize
    @player_color = "white"
    @player_symbols = [WHITE_PAWN, WHITE_ROOK, WHITE_KNIGHT,
                      WHITE_BISHOP, WHITE_QUEEN, WHITE_KING]
  end
end