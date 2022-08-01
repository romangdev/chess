# frozen_string_literal: true

require './lib/pieces/knight'
require 'colorize'

describe Knight do
  subject(:knight) { described_class.new(" \u2658 ") }

  describe 'generate_moves' do
    context 'when knight is white' do
      context 'when given an empty 8x8 board' do
        board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']]

        context 'when starting at [3, 3]' do
          it 'returns an array of 8 possible moves' do
            starting_location = [3, 3]
            result = knight.generate_moves(starting_location, board, knight.piece_symbol)
            expect(result.length).to eq(8)
          end
        end

        context 'when starting at [0, 0]' do
          it 'returns an array of 2 possible moves' do
            starting_location = [0, 0]
            result = knight.generate_moves(starting_location, board, knight.piece_symbol)
            expect(result.length).to eq(2)
          end
        end
      end

      context 'when given an empty 8x8 board and starting at [3, 3] with random pieces of different colors' do
        let(:white_piece) { double('white', piece_symbol: " \u2656 ") }
        let(:black_piece) { double('black', piece_symbol: " \u265f ".colorize(:black)) }

        it 'returns an array of 5 possible moves' do
          board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                   ['   ', '   ', '   ', '   ', white_piece, '   ', '   ', '   '],
                   ['   ', black_piece, '   ', '   ', '   ', '   ', '   ', '   '],
                   ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                   ['   ', white_piece, '   ', '   ', '   ', white_piece, '   ', '   '],
                   ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                   ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                   ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']]

          starting_location = [3, 3]
          result = knight.generate_moves(starting_location, board, knight.piece_symbol)
          expect(result.length).to eq(5)
        end
      end
    end

    context 'when knight is black' do
      subject(:knight) { described_class.new(" \u265e ".colorize(:black)) }

      context 'when given an empty 8x8 board' do
        board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                 ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']]

        context 'when starting at [3, 3]' do
          it 'returns an array of 8 possible moves' do
            starting_location = [3, 3]
            result = knight.generate_moves(starting_location, board, knight.piece_symbol)
            expect(result.length).to eq(8)
          end
        end

        context 'when starting at [0, 0]' do
          it 'returns an array of 2 possible moves' do
            starting_location = [0, 0]
            result = knight.generate_moves(starting_location, board, knight.piece_symbol)
            expect(result.length).to eq(2)
          end
        end
      end

      context 'when given an empty 8x8 board and starting at [3, 3] with random pieces of different colors' do
        let(:white_piece) { double('white', piece_symbol: " \u2656 ") }
        let(:black_piece) { double('black', piece_symbol: " \u265f ".colorize(:black)) }

        it 'returns an array of 7 possible moves' do
          board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                   ['   ', '   ', '   ', '   ', white_piece, '   ', '   ', '   '],
                   ['   ', black_piece, '   ', '   ', '   ', '   ', '   ', '   '],
                   ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                   ['   ', white_piece, '   ', '   ', '   ', white_piece, '   ', '   '],
                   ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                   ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                   ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']]

          starting_location = [3, 3]
          result = knight.generate_moves(starting_location, board, knight.piece_symbol)
          expect(result.length).to eq(7)
        end
      end
    end
  end
end
