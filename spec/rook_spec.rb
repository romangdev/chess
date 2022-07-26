require './lib/pieces/rook'
require 'colorize'

describe Rook do 
  subject(:rook) { described_class.new(" \u2656 ") }

  describe "#generate_moves" do 
    context "when rook is white" do
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
            moves = [[[4, 3], [5, 3], [6, 3], [7, 3]], [[2, 3], [1, 3], [0, 3]], 
            [[3, 4], [3, 5], [3, 6], [3, 7]], [[3, 2], [3, 1], [3, 0]]]
            current_location = [3, 3]
            result = rook.generate_moves(current_location, board, " \u2656 ")
            expect(result).to eq(moves)
          end
        end

        context "when starting at [7, 0] with no surrounding pieces" do 
          it "returns the defined moves array" do 
            current_location = [7, 0]
            result = rook.generate_moves(current_location, board, " \u2656 ")
            moves = [[], [[6, 0], [5, 0], [4, 0], [3, 0], [2, 0], [1, 0], [0, 0]], 
            [[7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7]], []]
            expect(result).to eq(moves)
          end
        end
      end

      context "when given 8x8 board with random pieces of both colors" do  
        let(:black_piece) { double("black_piece", piece_symbol: " \u265f ".colorize(:black)) }
        let(:white_piece) { double("white_piece", piece_symbol: " \u2656 ") }

        context "when starting a [3, 3]" do 
          it "returns the defined moves array" do 
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
            moves = [[[4, 3], [5, 3], [6, 3], [7, 3]], [], [[3, 4], [3, 5]], [[3, 2]]]
            expect(result).to eq(moves)
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
            [3, 7]], [[3, 2], [3, 1], [3, 0]]]
            result = rook.generate_moves(current_location, board, " \u2656 ")
            expect(result).to eq(moves)
          end
        end
      end
    end

    context "when rook is black" do 
      subject(:rook) { described_class.new(" \u265c ".colorize(:black)) }
      context "when given empty 8x8 board" do
        board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']] 

        context "when starting at [7, 0] with no surrounding pieces" do 
          it "returns the defined moves array" do 
            current_location = [7, 0]
            moves = [[], [[6, 0], [5, 0], [4, 0], [3, 0], [2, 0], [1, 0], [0, 0]], [[7, 1], 
            [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7]], []]
            result = rook.generate_moves(current_location, board, " \u265c ".colorize(:black))
            expect(result).to eq(moves)
          end
        end
      end

      context "when given 8x8 board with random pieces of both colors" do  
        let(:black_piece) { double("black_piece", piece_symbol: " \u265f ".colorize(:black)) }
        let(:white_piece) { double("white_piece", piece_symbol: " \u2656 ") }

        context "when starting a [3, 3]" do 
          it "returns the defined moves array" do 
            board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', white_piece, '   ', '   ', '   ', '   '],
                  ['   ', '   ', black_piece, '   ', '   ', '   ', white_piece, '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']] 
            current_location = [3, 3]
            moves = [[[4, 3], [5, 3], [6, 3], [7, 3]], [[2, 3]], [[3, 4], [3, 5], [3, 6]], []]
            result = rook.generate_moves(current_location, board, " \u265c ".colorize(:black))
            expect(result).to eq(moves)
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
            moves = [[[4, 3], [5, 3], [6, 3]], [[2, 3]], [[3, 4], [3, 5], [3, 6], [3, 7]], 
            [[3, 2], [3, 1], [3, 0]]]
            result = rook.generate_moves(current_location, board, " \u265c ".colorize(:black))
            expect(result).to eq(moves)
          end
        end
      end
    end
  end
end