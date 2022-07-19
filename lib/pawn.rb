# frozen_string_literal: true

class Pawn
  attr_reader :piece_symbol

  def initialize(piece_symbol)
    @first_move = true
    @piece_symbol = piece_symbol
  end
end