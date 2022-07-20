require './lib/pieces/pawn'

describe Pawn do 
  subject(:pawn) { described_class.new("test") }

  describe "#generate_moves" do 
    context "when it's pawns first move starting at [1, 0]" do
      before do 
        pawn.first_move_made = false
      end 
      it "returns array [[3, 0], [2, 0]]" do 
        current_location = [1, 0]
        expect(pawn.generate_moves(current_location)).to eq([[3,0], [2, 0]])
      end
    end
  end

  context "when it's NOT pawn's first move starting at [2, 5] and no pieces to take" do
    before do 
      pawn.first_move_made = true
    end 
    it "returns array [[3, 5]]" do 
      current_location = [2, 5]
      expect(pawn.generate_moves(current_location)).to eq([[3, 5]])
    end
  end

  context "when NOT pawn's first move starting at [0, 1] and one right diagonal piece to take" do
    before do 
      pawn.first_move_made = true
      board = [['   ', ' start ', '   '], ['   ', '   ', BLACK_ROOK]]
    end 
    xit "returns array [[5, 2]]...etc" do 
      current_location = [0, 1]
      expect(pawn.generate_moves(current_location, board)).to eq([[1, 1], [1, 2]])
    end
  end
end
