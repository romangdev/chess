# frozen_string_literal: true

class Rook
  attr_reader :piece_symbol

  def initialize(piece_symbol)
    @first_move_made = false
    @piece_symbol = piece_symbol
  end

  def generate_moves(current_location, chess_board, rook_color)
    moves = []
    vertical_moves = []
    horizontal_moves = []

    for i in 1..7
      unless current_location[0] + i > 7 || current_location[0] + i < 0
        vertical_moves << [current_location[0] + i, current_location[1]]
      end
    end

    for i in 1..7
      unless current_location[0] - i > 7 || current_location[0] - i < 0
        vertical_moves << [current_location[0] - i, current_location[1]]
      end
    end

    print "VERTICAL: #{vertical_moves}\n"

    for i in 1..7
      unless current_location[1] + i > 7 || current_location[1] + i < 0
        horizontal_moves << [current_location[0], current_location[1] + i]
      end
    end

    for i in 1..7
      unless current_location[1] - i > 7 || current_location[1] - i < 0
        horizontal_moves << [current_location[0], current_location[1] - i]
      end
    end

    print "HORIZONTAL#{horizontal_moves}\n"

    vertical_moves.each do |move|
      moves << move 
    end

    horizontal_moves.each do |move|
      moves << move 
    end

    moves
  end
end