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
          it "returns the moves array of 8 directions" do 
            current_location = [3, 3]
            result = queen.generate_moves(current_location, board, " \u2655 ")
            expect(result.length).to eq(8)
          end
        end  
        
        context "when starting at [7, 0] with no surrounding pieces" do 
          it "returns the defined moves array" do 
            current_location = [7, 0]
            moves = [[], [[6, 0], [5, 0], [4, 0], [3, 0], [2, 0], [1, 0], [0, 0]], 
            [[7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7]], [], [], [[6, 1], 
            [5, 2], [4, 3], [3, 4], [2, 5], [1, 6], [0, 7]], [], []]
            result = queen.generate_moves(current_location, board, " \u2655 ")
            expect(result).to eq(moves)
          end
        end
      end

      context "when given 8x8 board with random pieces of both colors" do  
        let(:black_piece) { double("black_piece", piece_symbol: " \u265f ".colorize(:black)) }
        let(:white_piece) { double("white_piece", piece_symbol: " \u2656 ") }

        context "when starting a [3, 3]" do 
          it "returns an array of 8 move directions" do 
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
            expect(result.length).to eq(8)
          end
        end

        context "when starting a [3, 3]" do 
          it "returns the defined moves array" do 
            board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  [black_piece, black_piece, black_piece, black_piece, black_piece, black_piece, black_piece, black_piece],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  [white_piece, white_piece, white_piece, white_piece, white_piece, white_piece, white_piece, white_piece],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']] 
            current_location = [3, 3]
            moves = [[[4, 3], [5, 3]], [[2, 3], [1, 3]], [[3, 4], [3, 5], [3, 6], 
            [3, 7]], [[3, 2], [3, 1], [3, 0]], [[4, 4],  [5, 5]], [[2, 4], [1, 5]], [[4, 2], 
            [5, 1]], [[2, 2], [1, 1]]]
            result = queen.generate_moves(current_location, board, " \u2655 ")
            expect(result).to eq(moves)
          end
        end
      end
    end

    context "when queen is black" do
      subject(:queen) { described_class.new(" \u265b ".colorize(:black)) }
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
          it "returns an array of 8 possible move directions" do 
            current_location = [3, 3]
            result = queen.generate_moves(current_location, board, " \u265b ".colorize(:black))
            expect(result.length).to eq(8)
          end
        end  
        
        context "when starting at [7, 0] with no surrounding pieces" do 
          it "returns an array of 8 possible move directions" do 
            current_location = [7, 0]
            result = queen.generate_moves(current_location, board, " \u265b ".colorize(:black))
            expect(result.length).to eq(8)
          end
        end
      end

      context "when given 8x8 board with random pieces of both colors" do  
        let(:black_piece) { double("black_piece", piece_symbol: " \u265f ".colorize(:black)) }
        let(:white_piece) { double("white_piece", piece_symbol: " \u2656 ") }

        context "when starting a [3, 3]" do 
          it "returns an array of 8 move directions" do 
            board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', white_piece, '   ', '   ', '   ', '   '],
                  ['   ', '   ', black_piece, '   ', '   ', '   ', white_piece, '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']] 
            current_location = [3, 3]
            result =  queen.generate_moves(current_location, board, " \u265b ".colorize(:black))
            expect(result.length).to eq(8)
          end
        end

        context "when starting a [3, 3]" do 
          it "returns an array of 8 move directions" do 
            board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  [black_piece, black_piece, black_piece, black_piece, black_piece, black_piece, black_piece, black_piece],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  [white_piece, white_piece, white_piece, white_piece, white_piece, white_piece, white_piece, white_piece],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']] 
            current_location = [3, 3]
            result = queen.generate_moves(current_location, board, " \u265b ".colorize(:black))
            expect(result.length).to eq(8)
          end
        end
      end
    end
  end
end