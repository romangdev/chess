require './lib/pieces/queen'
require 'colorize'

describe Queen do 
  subject(:queen) { described_class.new(" \u2655 ") }

  describe "#generate_moves" do 
    context "when queen is white" do
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
          it "returns an array of 27 possible moves" do 
            moves = [[4, 3], [5, 3], [6, 3], [2, 3], [3, 4], [3, 5], [3, 6], [3, 7],
            [3, 2], [3, 1], [3, 0], [4, 4], [5, 5], [6, 6], [4, 2], [5, 1], [6, 0],
            [2, 4], [2, 2]]
            current_location = [3, 3]
            result = queen.generate_moves(current_location, board, " \u2655 ")
            expect(result.length).to eq(27)
          end
        end  
        
        context "when starting at [7, 0] with no surrounding pieces" do 
          it "returns an array of 21 possible moves" do 
            current_location = [7, 0]
            result = queen.generate_moves(current_location, board, " \u2655 ")
            expect(result.length).to eq(21)
          end
        end
      end

      context "when given 8x8 board with random pieces of both colors" do  
        let(:black_piece) { double("black_piece", piece_symbol: " \u265f ".colorize(:black)) }
        let(:white_piece) { double("white_piece", piece_symbol: " \u2656 ") }

        context "when starting a [3, 3]" do 
          it "returns an array of 20 moves" do 
            board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', white_piece, '   ', '   ', '   ', '   '],
                  ['   ', '   ', black_piece, '   ', '   ', '   ', white_piece, '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']] 
            current_location = [3, 3]
            result =  queen.generate_moves(current_location, board, " \u2655 ")
            expect(result.length).to eq(20)
          end
        end

        context "when starting a [3, 3]" do 
          it "returns an array of 19 moves" do 
            board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  [black_piece, black_piece, black_piece, black_piece, black_piece, black_piece, black_piece, black_piece],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  [white_piece, white_piece, white_piece, white_piece, white_piece, white_piece, white_piece, white_piece],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']] 
            current_location = [3, 3]
            result = queen.generate_moves(current_location, board, " \u2655 ")
            expect(result.length).to eq(19)
          end
        end
      end
    end
  end
end