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

    context "when given 8x8 board with random pieces of both colors" do  
      let(:black_piece) { double("black_piece", piece_symbol: " \u265f ".colorize(:black)) }
      let(:white_piece) { double("white_piece", piece_symbol: " \u265f ") }

      context "when starting a [3, 3]" do 
        it "returns an array of 7 moves" do 
          board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', white_piece, '   ', '   ', '   ', '   '],
                ['   ', '   ', black_piece, '   ', '   ', '   ', white_piece, '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']] 
          current_location = [3, 3]
          result = rook.generate_moves(current_location, board, " \u2656 ")
          expect(result.length).to eq(7)
        end
      end

      context "when starting a [3, 3]" do 
        it "returns an array of 11 moves" do 
          board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                [black_piece, black_piece, black_piece, black_piece, black_piece, black_piece, black_piece, black_piece],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                [white_piece, white_piece, white_piece, white_piece, white_piece, white_piece, white_piece, white_piece],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']] 
          current_location = [3, 3]
          result = rook.generate_moves(current_location, board, " \u2656 ")
          expect(result.length).to eq(11)
        end
      end
    end
  end
end