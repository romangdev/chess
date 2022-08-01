# frozen_string_literal: true

require_relative 'chess_pieces'

class PlayerWhite
  attr_reader :player_pieces, :player_color

  include ChessPieces

  def initialize
    @player_color = 'white'
    @player_pieces = [WHITE_PAWN, WHITE_ROOK, WHITE_KNIGHT,
                      WHITE_BISHOP, WHITE_QUEEN, WHITE_KING]
  end
end
