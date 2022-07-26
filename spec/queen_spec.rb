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
          it "returns an array of 8 possible move directions" do 
            current_location = [3, 3]
            result = queen.generate_moves(current_location, board, " \u2655 ")
            expect(result.length).to eq(8)
          end
        end  
        
        context "when starting at [7, 0] with no surrounding pieces" do 
          it "returns an array of 8 possible move directions" do 
            current_location = [7, 0]
            result = queen.generate_moves(current_location, board, " \u2655 ")
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
            result =  queen.generate_moves(current_location, board, " \u2655 ")
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
            result = queen.generate_moves(current_location, board, " \u2655 ")
            expect(result.length).to eq(8)
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