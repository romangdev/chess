require './lib/pieces/pawn'
require 'colorize'

describe Pawn do 
  subject(:pawn) { described_class.new(" \u2659 ") }

  describe "#generate_moves" do 
    context "when pawn is white" do 
      context "when it's pawns first move starting at [1, 0]" do
        before do 
          pawn.first_move_made = false
        end 
        it "returns array [[3, 0], [2, 0]]" do 
          current_location = [1, 0]
          expect(pawn.generate_moves(current_location)).to eq([[3,0], [2, 0]])
        end
      end

      context "when not pawn's first move" do 
        context "when starting at [2, 5] and no pieces to take" do
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[3, 5]]" do 
            current_location = [2, 5]
            expect(pawn.generate_moves(current_location)).to eq([[3, 5]])
          end
        end

        context "when starting at [0, 1] and one right diagonal piece to take" do
          let(:rook) { double("rook", piece_symbol: " \u265c ".colorize(:black))}
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[1, 2], [1, 1]]" do 
            board = [['   ', ' start ', '   '], ['   ', '   ', rook]]
            current_location = [0, 1]
            expect(pawn.generate_moves(current_location, board)).to eq([[1, 2], [1, 1]])
          end
        end

        context "when starting at [0, 1] and one left diagonal piece to take" do
          let(:rook) { double("rook", piece_symbol: " \u265c ".colorize(:black))}
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[1, 0], [1, 1]]" do 
            board = [['   ', ' start ', '   '], [rook, '   ', '   ']]
            current_location = [0, 1]
            expect(pawn.generate_moves(current_location, board)).to eq([[1, 0], [1, 1]])
          end
        end

        context "when starting at [0, 1] and both diagonals have capturable pieces" do
          let(:rook) { double("rook", piece_symbol: " \u265c ".colorize(:black))}
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[1, 0], [1, 1]]" do 
            board = [['   ', ' start ', '   '], [rook, '   ', rook]]
            current_location = [0, 1]
            expect(pawn.generate_moves(current_location, board)).to eq([[1,2], [1, 0], [1, 1]])
          end
        end
      end
    end

    context "when pawn is black" do 
      subject(:pawn) { described_class.new(" \u2659 ".colorize(:black)) }
      context "when it's pawns first move starting at [1, 0]" do
        before do 
          pawn.first_move_made = false
        end 
        it "returns array [[3, 0], [2, 0]]" do 
          current_location = [1, 0]
          expect(pawn.generate_moves(current_location)).to eq([[3,0], [2, 0]])
        end
      end

      context "when not pawn's first move" do 
        context "when starting at [2, 5] and no pieces to take" do
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[3, 5]]" do 
            current_location = [2, 5]
            expect(pawn.generate_moves(current_location)).to eq([[3, 5]])
          end
        end

        context "when starting at [0, 1] and one right diagonal piece to take" do
          let(:rook) { double("rook", piece_symbol: " \u265c ")}
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[1, 2], [1, 1]]" do 
            board = [['   ', ' start ', '   '], ['   ', '   ', rook]]
            current_location = [0, 1]
            expect(pawn.generate_moves(current_location, board)).to eq([[1, 2], [1, 1]])
          end
        end

        context "when starting at [0, 1] and one left diagonal piece to take" do
          let(:rook) { double("rook", piece_symbol: " \u265c ")}
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[1, 0], [1, 1]]" do 
            board = [['   ', ' start ', '   '], [rook, '   ', '   ']]
            current_location = [0, 1]
            expect(pawn.generate_moves(current_location, board)).to eq([[1, 0], [1, 1]])
          end
        end

        context "when starting at [0, 1] and both diagonals have capturable pieces" do
          let(:rook) { double("rook", piece_symbol: " \u265c ")}
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[1, 0], [1, 1]]" do 
            board = [['   ', ' start ', '   '], [rook, '   ', rook]]
            current_location = [0, 1]
            expect(pawn.generate_moves(current_location, board)).to eq([[1,2], [1, 0], [1, 1]])
          end
        end
      end
    end
  end
end
