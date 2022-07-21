require './lib/pieces/pawn'
require 'colorize'

describe Pawn do 
  subject(:pawn) { described_class.new(" \u2659 ") }

  describe "#generate_moves" do 
    context "when pawn is white" do 
      board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']]

      context "when it's pawns first move starting at [1, 0]" do
        before do 
          pawn.first_move_made = false
        end 
        it "returns array [[3, 0], [2, 0]]" do 
          current_location = [1, 0]
          expect(pawn.generate_moves(current_location, board, " \u2659 ")).to eq([[3,0], [2, 0]])
        end
      end

      context "when not pawn's first move" do 
        context "when starting at [2, 5] and no pieces to take" do
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[3, 5]]" do 
            current_location = [2, 5]
            expect(pawn.generate_moves(current_location, board, " \u2659 ")).to eq([[3, 5]])
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
            expect(pawn.generate_moves(current_location, board, " \u2659 ")).to eq([[1, 2], [1, 1]])
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
            expect(pawn.generate_moves(current_location, board, " \u2659 ")).to eq([[1, 0], [1, 1]])
          end
        end

        context "when starting at [0, 1] and both diagonals have capturable pieces" do
          let(:rook) { double("rook", piece_symbol: " \u265c ".colorize(:black))}
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[1, 2], [1, 0], [1, 1]]" do 
            board = [['   ', ' start ', '   '], [rook, '   ', rook]]
            current_location = [0, 1]
            expect(pawn.generate_moves(current_location, board, " \u2659 ")).to eq([[1,2], [1, 0], [1, 1]])
          end
        end

        context "when starting at [0, 1] with a piece in front of pawn with no capturables" do
          let(:rook) { double("rook", piece_symbol: " \u265c ".colorize(:black))}
          before do 
            pawn.first_move_made = true
          end 
          it "returns array []" do 
            board = [['   ', ' start ', '   '], ['   ', rook, '   ']]
            current_location = [0, 1]
            expect(pawn.generate_moves(current_location, board, " \u2659 ")).to eq([])
          end
        end

        context "when starting at [0, 1] with a piece in front of pawn with two capturables" do
          let(:rook) { double("rook", piece_symbol: " \u265c ".colorize(:black))}
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[1, 0], [1, 2]]" do 
            board = [['   ', ' start ', '   '], [rook, rook, rook]]
            current_location = [0, 1]
            expect(pawn.generate_moves(current_location, board, " \u2659 ")).to eq([[1, 2], [1, 0]])
          end
        end
      end
    end

    context "when pawn is black" do 
      subject(:pawn) { described_class.new(" \u2659 ".colorize(:black)) }
      board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
              ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']]

      context "when it's pawns first move starting at [1, 0]" do
        before do 
          pawn.first_move_made = false
        end 
        it "returns array [[4, 0], [5, 0]]" do 
          current_location = [6, 0]
          result = pawn.generate_moves(current_location, board, pawn.piece_symbol)
          expect(result).to eq([[4,0], [5, 0]])
        end
      end

      context "when not pawn's first move" do 
        context "when starting at [3, 5] and no pieces to take" do
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[2, 5]]" do 
            current_location = [3, 5]
            result = pawn.generate_moves(current_location, board, pawn.piece_symbol)
            expect(result).to eq([[2, 5]])
          end
        end

        context "when starting at [1, 1] and one right diagonal piece to take" do
          let(:rook) { double("rook", piece_symbol: " \u265c ")}
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[0, 0], [0, 1]]" do 
            board = [[rook, '   ', '   '], ['   ', '   ', '   ']]
            current_location = [1, 1]
            result = pawn.generate_moves(current_location, board, pawn.piece_symbol)
            expect(result).to eq([[0, 0], [0, 1]])
          end
        end

        context "when starting at [1, 1] and one left diagonal piece to take" do
          let(:rook) { double("rook", piece_symbol: " \u265c ")}
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[0, 2], [0, 1]]" do 
            board = [['   ', '   ', rook], ['   ', '   ', '   ']]
            current_location = [1, 1]
            result = pawn.generate_moves(current_location, board, pawn.piece_symbol)
            expect(result).to eq([[0, 2], [0, 1]])
          end
        end

        context "when starting at [1, 1] and both diagonals have capturable pieces" do
          let(:rook) { double("rook", piece_symbol: " \u265c ")}
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[1, 2], [1, 0], [1, 1]]" do 
            board = [[rook, '   ', rook], ['   ', '   ', '   ']]
            current_location = [1, 1]
            result = pawn.generate_moves(current_location, board, pawn.piece_symbol)
            expect(result).to eq([[0, 0], [0, 2], [0, 1]])
          end
        end

        context "when starting at [1, 1] with a piece in front of you with no capturables" do
          let(:rook) { double("rook", piece_symbol: " \u265c ")}
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[1, 0], [1, 1]]" do 
            board = [['   ', rook, '   '], ['   ', '   ', '   ']]
            current_location = [1, 1]
            result = pawn.generate_moves(current_location, board, pawn.piece_symbol)
            expect(result).to eq([])
          end
        end

        context "when starting at [1, 1] with a piece in front of pawn with two capturables" do
          let(:rook) { double("rook", piece_symbol: " \u265c ")}
          before do 
            pawn.first_move_made = true
          end 
          it "returns array [[0, 0], [0, 2]]" do 
            board = [[rook, rook, rook], ['   ', '   ', '   ']]
            current_location = [1, 1]
            result = pawn.generate_moves(current_location, board, pawn.piece_symbol)
            expect(result).to eq([[0, 0], [0, 2]])
          end
        end
      end
    end
  end
end
