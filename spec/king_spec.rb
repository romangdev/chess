require './lib/pieces/king'
require 'colorize'

describe King do 
  subject(:king) { described_class.new(" \u2654 ") }
  describe "#generate_moves" do 
     context "when given empty 8x8 board with no surrounding pieces" do 
       context "when starting at [3, 3]" do 
        board = [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']]
      
         it "returns the specified 'moves' array" do 
            current_location = [3, 3]
            result = king.generate_moves(current_location, board, king.piece_symbol)
            expect(result).to include([2, 2], [2, 3], [2, 4], [3, 4], [3, 2], [4, 3], [4, 2], [4, 4])
         end 
       end
     end
  end
end