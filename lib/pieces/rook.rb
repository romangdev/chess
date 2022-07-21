# frozen_string_literal: true

class Rook
  attr_reader :piece_symbol

  def initialize(piece_symbol)
    @first_move_made = false
    @piece_symbol = piece_symbol
  end

  def generate_moves()
  end
end