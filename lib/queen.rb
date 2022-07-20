# frozen_string_literal: true

class Queen
  attr_reader :piece_symbol

  def initialize(piece_symbol)
    @piece_symbol = piece_symbol
  end
end