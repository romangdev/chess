require './lib/game.rb'

describe Game do 
  subject(:game) { described_class.new }

  describe "#convert_player_location" do 
    context "when player enters 'a8'" do 
      it "returns [0, 7]" do 
        player_choice = "a8"
        result = game.convert_player_location(player_choice)
        expect(result).to eq([0, 7])
      end
    end
  end
end