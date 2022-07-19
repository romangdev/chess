require './lib/board.rb'

describe Board do 
  subject(:board) { described_class.new }

  describe "#generate_board" do
    context "when called" do 
      it "returns an array with length of 8" do 
        board.generate_board
        expect(board.chess_board.length).to eq(8)
      end

      it "returns array[0] of 8 length" do 
        board.generate_board
        expect(board.chess_board[0].length).to eq(8)
      end

      it "returns array[6] of 8 length" do 
        board.generate_board
        expect(board.chess_board[6].length).to eq(8)
      end

      it "returns a white rook at array[0][0]" do 
        board.generate_board
        expect(board.chess_board[0][0]).to eq(" \u2655 ")
      end

      it "returns a black pawn at array[6][3]" do 
        board.generate_board
        expect(board.chess_board[6][3]).to eq("\e[0;30;49m ♟ \e[0m")
      end

      it "returns a white queen at array[0][3]" do 
        board.generate_board
        expect(board.chess_board[0][3]).to eq(" \u2655 ")
      end
    end
  end
end