# frozen_string_literal: true

class King
  attr_reader :piece_symbol

  def initialize(piece_symbol)
    @first_move_made = false
    @piece_symbol = piece_symbol
  end

  def generate_moves(current_location, chess_board, king_color)
    
  end

  private 
end