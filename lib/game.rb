# frozen_string_literal: true

require_relative 'chess_pieces'
require_relative 'player_black'
require_relative 'player_white'
require_relative 'board'

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

  def get_player_location
    puts <<-HEREDOC 
Choose piece to move (type column then row with no space)...
Example: a1, h3, g8, etc.
    HEREDOC

    player_choice = gets.chomp.split("")
    return player_choice
  end

  def convert_player_location(player_choice)
    player_choice[0] = convert_player_column(player_choice)
    player_choice[1] = convert_player_row(player_choice)
    print player_choice
    return player_choice

    # verify player location choice is within array AND includes their piece
  end

  private 

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