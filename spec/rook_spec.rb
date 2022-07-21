require './lib/pieces/rook'
require 'colorize'

describe Rook do 
  subject(:rook) { described_class.new(" \u2656 ") }

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
      
      context "when starting at [3, 3] with no surrounding pieces" do 
        it "returns the defined \"moves\" array of 14 possible moves" do 
          moves = [[4, 3], [5, 3], [6, 3], [7, 3], [2, 3], [1, 3], [0, 3], 
          [3, 4], [3, 5], [3, 6], [3, 7], [3, 2], [3, 1], [3, 0]]
          current_location = [3, 3]
          result = rook.generate_moves(current_location, board, " \u2656 ")
          expect(result).to eq(moves)
        end
      end

      context "when starting at [7, 0] with no surrounding pieces" do 
        it "returns an array of 14 possible moves" do 
          current_location = [7, 0]
          result = rook.generate_moves(current_location, board, " \u2656 ")
          expect(result.length).to eq(14)
        end
      end
    end
  end
end