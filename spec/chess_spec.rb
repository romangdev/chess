# require './lib/chess'
# require './lib/pieces/queen'
# require 'colorize'

# describe Chess do 
#   # subject(:chess) { described_class.new }
#   # # let(:queen) { instance_double(Queen, piece_symbol: " \u265b ".colorize(:black)) }

#   # describe "#handle_promotion_by_color" do 
#   #   context "when white pawn is in 8th row" do 
#   #     board = [['   '], ['   '], ['   '], ['   '], 
#   #     ['   '], ['   '], ['   '], [" \u2659 "]]

#   #     before do 
#   #       allow(Queen).to receive(:new).with(" \u2655 ")
#   #     end

#   #     #ISSUE IS THAT QUEEN.NEW IS CREATING A NIL. 
#   #     it "turns pawn into a queen" do 
#   #       chess.handle_promotion_by_color(board, " \u2659 ", 0)
#   #       expect(board[7][0]).to eq(" \u2655 ")
#   #     end
#   #   end
#   # end
# end