# frozen_string_literal: true

require './lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#generate_board' do
    context 'when called' do
      it 'returns an array with length of 8' do
        board.generate_board
        expect(board.chess_board.length).to eq(8)
      end

      it 'returns array[0] of 8 length' do
        board.generate_board
        expect(board.chess_board[0].length).to eq(8)
      end

      it 'returns array[6] of 8 length' do
        board.generate_board
        expect(board.chess_board[6].length).to eq(8)
      end

      it 'returns a Rook object at array[0][0]' do
        board.generate_board
        expect(board.chess_board[0][0]).to be_a(Rook)
      end

      it 'returns a Pawn object at array[6][3]' do
        board.generate_board
        expect(board.chess_board[6][3]).to be_a(Pawn)
      end

      it 'returns a Queen object at array[0][3]' do
        board.generate_board
        expect(board.chess_board[0][3]).to be_a(Queen)
      end
    end
  end
end
