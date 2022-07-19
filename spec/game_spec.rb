require './lib/game.rb'

describe Game do 
  subject(:game) { described_class.new }

  # describe "#convert_player_location" do 
  #   context "when player enters 'a8'" do 
  #     before do 
  #       allow(game).to receive(:convert_player_column).and_return(0)
  #     end
  #     it "returns [0, 7]" do 
  #       player_choice = "a8"
  #       result = game.convert_player_location(player_choice)
  #       expect(result).to eq([0, 7])
  #     end
  #   end
  # end

  describe "#get_player_location" do 
    context "when invalid location is entered once" do 
      before do 
        allow(game).to receive(:prompt_player_location)
        allow(game).to receive(:gets).and_return("hello", "a5")
        allow(game).to receive(:verify_player_location).and_return(false, true)
      end
      it "receives error message once" do 
        error_msg = "That's location isn't on the board - please try again!"
        expect(game).to receive(:puts).with(error_msg).once
        game.get_player_location
      end
    end

    context "when invalid location is entered twice" do 
      before do 
        allow(game).to receive(:prompt_player_location)
        allow(game).to receive(:gets).and_return("hello", "c9", "h3")
        allow(game).to receive(:verify_player_location).and_return(false, false, true)
      end
      it "receives error message twice" do 
        error_msg = "That's location isn't on the board - please try again!"
        expect(game).to receive(:puts).with(error_msg).twice
        game.get_player_location
      end
    end

    context "when valid location is entered on first try" do 
      before do 
        allow(game).to receive(:prompt_player_location)
        allow(game).to receive(:gets).and_return("h3")
        allow(game).to receive(:verify_player_location).and_return(true)
      end
      it "does not receive an error message" do 
        error_msg = "That's location isn't on the board - please try again!"
        expect(game).not_to receive(:puts).with(error_msg)
        game.get_player_location
      end
    end
  end

  describe "#verify_player_location" do 
    context "when player enters invalid location" do 
      context "when player enters 'b77'" do 
        it "returns false" do 
          player_choice = "b77"
          result = game.verify_player_location(player_choice)
          expect(result).to eq(false)
        end
      end

      context "when player enters 'i9'" do 
        it "returns false" do 
          player_choice = "i9"
          result = game.verify_player_location(player_choice)
          expect(result).to eq(false)
        end
      end

      context "when player enters '1'" do 
        it "returns false" do 
          player_choice = "1"
          result = game.verify_player_location(player_choice)
          expect(result).to eq(false)
        end
      end

      context "when player enters 'b0'" do 
        it "returns false" do 
          player_choice = "b0"
          result = game.verify_player_location(player_choice)
          expect(result).to eq(false)
        end
      end
    end

    context "when player enters valid location" do 
      context "when player enters 'd5'" do 
        it "returns true" do 
          player_choice = "d5"
          result = game.verify_player_location(player_choice)
          expect(result).to eq(true)
        end
      end

      context "when player enters 'h8'" do 
        it "returns true" do 
          player_choice = "h8"
          result = game.verify_player_location(player_choice)
          expect(result).to eq(true)
        end
      end
    end
  end
end