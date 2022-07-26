require './lib/pieces/bishop'
require 'colorize'

describe Bishop do 
  describe "#generate_moves" do 
    context "when bishop is white" do 
      subject(:bishop) { described_class.new(" \u2657 ") }

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
          it  "returns the defined \"moves\" array moves" do
            moves = [[[4, 4], [5, 5], [6, 6], [7, 7]], [[2, 4], [1, 5], [0, 6]], 
            [[4, 2], [5, 1], [6, 0]], [[2, 2], [1, 1], [0, 0]]]
            current_location = [3, 3]
            result = bishop.generate_moves(current_location, board, " \u2657 ")
            expect(result).to eq(moves)
          end
        end

        context "when starting at [7, 0] with no surrounding pieces" do 
          it "returns the defined \"moves\" array moves" do 
            current_location = [7, 0]
            result = bishop.generate_moves(current_location, board, " \u2657 ")
            moves = [[], [[6, 1], [5, 2], [4, 3], [3, 4], [2, 5], [1, 6], 
            [0, 7]], [], []]
            expect(result).to eq(moves)
          end
        end

        context "when given 8x8 board with random pieces of both colors" do  
          let(:black_piece) { double("black_piece", piece_symbol: " \u265f ".colorize(:black)) }
          let(:white_piece) { double("white_piece", piece_symbol: " \u2656 ") }

          context "when starting a [3, 3]" do 
            it "returns the defined \"moves\" array moves" do 
              board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                    [black_piece, black_piece, black_piece, black_piece, black_piece, black_piece, black_piece, black_piece],
                    ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                    ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                    ['   ', '   ', white_piece, '   ', '   ', '   ', '   ', '   '],
                    ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                    [white_piece, white_piece, white_piece, white_piece, white_piece, white_piece, white_piece, white_piece],
                    ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']] 
              current_location = [3, 3]
              result = bishop.generate_moves(current_location, board, " \u2657 ")
              moves = [[[4, 4], [5, 5]], [[2, 4], [1, 5]], [], [[2, 2], [1, 1]]]
              expect(result).to eq(moves)
            end
          end
        end
      end
    end

    context "when bishop is black" do 
      subject(:bishop) { described_class.new(" \u265d ".colorize(:black)) }
      
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
            moves = [[[4, 4], [5, 5], [6, 6], [7, 7]], [[2, 4], [1, 5], [0, 6]], 
            [[4, 2], [5, 1], [6, 0]], [[2, 2], [1, 1], [0, 0]]]
            current_location = [3, 3]
            result = bishop.generate_moves(current_location, board, " \u265d ".colorize(:black))
            expect(result).to eq(moves)
          end
        end

        context "when starting at [7, 0] with no surrounding pieces" do 
          it "returns an array of 4 possible move directions" do 
            current_location = [7, 0]
            result = bishop.generate_moves(current_location, board, " \u265d ".colorize(:black))
            expect(result.length).to eq(4)
          end
        end

        context "when given 8x8 board with random pieces of both colors" do  
          let(:black_piece) { double("black_piece", piece_symbol: " \u265f ".colorize(:black)) }
          let(:white_piece) { double("white_piece", piece_symbol: " \u2656 ") }

          context "when starting a [3, 3]" do 
            it "returns an array of 4 move directions" do 
              board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                    [black_piece, black_piece, black_piece, black_piece, black_piece, black_piece, black_piece, black_piece],
                    ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                    ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                    ['   ', '   ', white_piece, '   ', '   ', '   ', '   ', '   '],
                    ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                    [white_piece, white_piece, white_piece, white_piece, white_piece, white_piece, white_piece, white_piece],
                    ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']] 
              current_location = [3, 3]
              result = bishop.generate_moves(current_location, board, " \u265d ".colorize(:black))
              expect(result.length).to eq(4)
            end
          end
        end
      end
    end
  end
end