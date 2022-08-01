# frozen_string_literal: true

require_relative 'chess_pieces'

class PlayerBlack
  attr_reader :player_pieces, :player_color

  include ChessPieces

  def initialize
    @player_color = 'black'
    @player_pieces = [BLACK_PAWN, BLACK_ROOK, BLACK_KNIGHT,
                      BLACK_BISHOP, BLACK_QUEEN, BLACK_KING]
  end
end
