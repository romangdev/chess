require './lib/pieces/bishop'
require 'colorize'

describe Bishop do 
  subject(:bishop) { described_class.new(" \u2656 ") }

  describe "#generate_moves" do 
    context "when given empty 8x8 board" do
      board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']] 
    
      context "when starting a [3, 3] with no pieces on board" do 
        it  "returns the defined \"moves\" array of 13 possible moves" do
          moves = [[2, 4], [1, 5], [0, 6], [2, 3], [1, 2], [0, 1], [4, 4], [5, 5],
                  [6, 6], [7, 7], [4, 2], [5, 1], [6, 0]]
          current_location = [3, 3]
          result = bishop.generate_moves(current_location, board, " \u2656 ")
          expect(result).to eq(moves)
        end
      end
    end
  end
end