require './lib/pieces/bishop'
require 'colorize'

describe Bishop do 
  subject(:bishop) { described_class.new(" \u2657 ") }

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
          moves = [[4, 4], [5, 5], [6, 6], [7, 7], [2, 4], [1, 5], [0, 6], [4, 2], 
          [5, 1], [6, 0], [2, 2], [1, 1], [0, 0]]
          current_location = [3, 3]
          result = bishop.generate_moves(current_location, board, " \u2657 ")
          expect(result).to eq(moves)
        end
      end

      context "when starting at [7, 0] with no surrounding pieces" do 
        it "returns an array of 7 possible moves" do 
          current_location = [7, 0]
          result = bishop.generate_moves(current_location, board, " \u2657 ")
          expect(result.length).to eq(7)
        end
      end
    end
  end
end