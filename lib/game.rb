# frozen_string_literal: true

require_relative 'chess_pieces'
require_relative 'player_black'
require_relative 'player_white'
require_relative 'board'

# contains the majority of core game functions, especially those interacting
# with the player
class Game
  include ChessPieces

  COLUMN_MATCH = {
    "a" => 0,
    "b" => 1,
    "c" => 2,
    "d" => 3,
    "e" => 4,
    "f" => 5,
    "g" => 6,
    "h" => 7,
  }

  def get_player_location(player_color)
    flag = false
    until flag == true
      prompt_player_location(player_color) 
      player_choice = gets.chomp.downcase.split("")
      flag = verify_player_location(player_choice)
      puts "That's location isn't on the board - please try again!" if flag == false
    end
    player_choice
  end

  def verify_player_location(player_choice)
    if player_choice.length != 2 || player_choice[0] !~ /[a-h]/ ||
      player_choice[1] !~ /[1-8]/

      return false
    else 
      return true
    end
  end

  def convert_player_location(player_choice)
    player_choice[0] = convert_player_column(player_choice)
    player_choice[1] = convert_player_row(player_choice)
    print "#{player_choice.reverse}\n"
    return player_choice.reverse
  end

  def verify_location_piece(player_pieces, chosen_location, board_array)
    player_pieces.each do |piece|
      return true if board_array[chosen_location[0]][chosen_location[1]] == piece
    end

    false
  end

  def get_piece_choice_confirm
    puts "Confirm you want to move this piece (y/n)"
    piece_confirm = gets.chomp.downcase
    return piece_confirm
  end

  def handle_confirm_piece_choice(piece_confirm)
    return true if piece_confirm == "y" || piece_confirm == "yes"

    false
  end

  private 

  def prompt_player_location(player_color)
    puts <<-HEREDOC 
#{player_color.upcase}: Choose piece to move (type column then row with no space)...
Example: a1, h3, g8, etc.
    HEREDOC
  end

  def convert_player_column(player_choice)
    COLUMN_MATCH.each do |key, value|
      if player_choice[0] == key
        return value
      end
    end
  end

  def convert_player_row(player_choice)
    player_choice[1] = player_choice[1].to_i
    return player_choice[1] - 1
  end
end