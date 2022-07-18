describe Board do 
  subject(:board) { described_class.new }
  
  describe "#generate_board" do
    context "when called" do 
      it "returns an 8x8 unicode square chess board (as array of arrays)" do 
        expect(board.chess_board).to eq()
      end
    end
  end

  describe "display_board" do 
  end
end