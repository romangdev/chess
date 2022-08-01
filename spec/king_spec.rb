# frozen_string_literal: true

require './lib/pieces/king'
require 'colorize'

describe King do
  subject(:king) { described_class.new(" \u2654 ") }
  describe '#generate_moves' do
    context 'when queen is white' do
      context 'when given empty 8x8 board with no surrounding pieces' do
        board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']]

        context 'when starting at [3, 3]' do
          it "returns the specified 'moves' array" do
            current_location = [3, 3]
            result = king.generate_moves(current_location, board, king.piece_symbol)
            expect(result).to include([2, 2], [2, 3], [2, 4], [3, 4], [3, 2], [4, 3], [4, 2], [4, 4])
          end
        end

        context 'when starting at [0, 0]' do
          it "returns the specified 'moves' array" do
            current_location = [0, 0]
            result = king.generate_moves(current_location, board, king.piece_symbol)
            expect(result).to include([0, 1], [1, 0], [1, 1])
          end
        end
      end

      context 'when given 8x8 board with random pieces surrounding' do
        let(:white_piece) { double('white', piece_symbol: " \u2656 ") }
        let(:black_piece) { double('black', piece_symbol: " \u265f ".colorize(:black)) }
        context 'when starting at [1, 1]' do
          it 'returns array of length 6' do
            board = [[white_piece, '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                     [white_piece, '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                     ['   ', black_piece, '   ', '   ', '   ', '   ', '   ', '   '],
                     ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                     ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                     ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                     ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                     ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']]
            current_location = [1, 1]
            result = king.generate_moves(current_location, board, king.piece_symbol)
            expect(result.length).to eq(6)
          end
        end
      end
    end

    context 'when queen is black' do
      subject(:king) { described_class.new(" \u265b ".colorize(:black)) }

      context 'when given empty 8x8 board with no surrounding pieces' do
        board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']]

        context 'when starting at [3, 3]' do
          it "returns the specified 'moves' array" do
            current_location = [3, 3]
            result = king.generate_moves(current_location, board, king.piece_symbol)
            expect(result).to include([2, 2], [2, 3], [2, 4], [3, 4], [3, 2], [4, 3], [4, 2], [4, 4])
          end
        end

        context 'when starting at [0, 0]' do
          it "returns the specified 'moves' array" do
            current_location = [0, 0]
            result = king.generate_moves(current_location, board, king.piece_symbol)
            expect(result).to include([0, 1], [1, 0], [1, 1])
          end
        end
      end

      context 'when given 8x8 board with random pieces surrounding' do
        let(:white_piece) { double('white', piece_symbol: " \u2656 ") }
        let(:black_piece) { double('black', piece_symbol: " \u265f ".colorize(:black)) }
        context 'when starting at [1, 1]' do
          it 'returns array of length 6' do
            board = [[white_piece, '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                     [white_piece, '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                     ['   ', black_piece, '   ', '   ', '   ', '   ', '   ', '   '],
                     ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                     ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                     ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                     ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                     ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']]
            current_location = [1, 1]
            result = king.generate_moves(current_location, board, king.piece_symbol)
            expect(result.length).to eq(7)
          end
        end
      end
    end
  end
end
