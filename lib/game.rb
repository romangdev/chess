# frozen_string_literal: true

require_relative 'chess_pieces'
require_relative 'player_black'
require_relative 'player_white'
require_relative 'board'

# contains the majority of core game functions, especially those interacting
# with the player
class Game
  include ChessPieces

  # used to match chess board letter columns with their respective array elements
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

  # gets the starting location the player wants to move a piece from
  def get_player_location(player_color)
    flag = false
    until flag == true
      prompt_player_location(player_color) 
      player_choice = gets.chomp.downcase
      return player_choice if player_choice == "draw" || player_choice == "d"

      player_choice = player_choice.split("")
      flag = verify_player_location(player_choice)
      puts "That's location isn't on the board - please try again!" if flag == false
    end
    player_choice
  end

  # verify that a player wants to draw
  def verify_draw(player_color)
    puts "#{player_color.upcase}: Are you sure you want a draw?"
    answer = gets.chomp.downcase
  end

  # end the game if both players want a draw, or continue if both or one do not want a draw
  def handle_ask_for_draw(player_choice, player_white, player_black, done)
    if player_choice == "draw" || player_choice == "d"
      white_answer = verify_draw(player_white.player_color)
      black_answer = verify_draw(player_black.player_color)

      if (white_answer == "y" || white_answer == "yes") && (black_answer == "y" || black_answer == "yes")
        puts "Game ends in a DRAW"
        return "end"
      else 
        puts "So we shall CONTINUE!"
        return false
      end
    else
      return true
    end
  end

  # gets the ending location a player wants to move their selected piece to
  def get_end_location(player_color)
    flag = false
    until flag == true
      prompt_player_ending_location(player_color) 
      player_choice = gets.chomp.downcase.split("")
      flag = verify_player_location(player_choice)
      puts "That's location isn't on the board - please try again!" if flag == false
    end
    player_choice
  end

  # ensures the player's ending location choice is possible for the selected piece to move to
  def verify_possible_move(possible_moves, player_end)
    return true if possible_moves.include?(player_end)

    false
  end

  # ensures any player's chosen location (start or end) is on the board
  def verify_player_location(player_choice)
    if player_choice.length != 2 || player_choice[0] !~ /[a-h]/ ||
      player_choice[1] !~ /[1-8]/

      return false
    else 
      return true
    end
  end

  # converts letter, number board location notation to number, number notation for backend array 
  # representing chess board (ex: b3 --> [1, 2]) 
  def convert_player_location(player_choice)
    player_choice[0] = convert_player_column(player_choice)
    player_choice[1] = convert_player_row(player_choice)
    return player_choice.reverse
  end

  # verify what piece (or lack of piece) a location selected by player holds
  def verify_location_piece(player_pieces, chosen_location, board_array)
    player_pieces.each do |piece|
      if board_array[chosen_location[0]][chosen_location[1]].is_a? String
        return true if board_array[chosen_location[0]][chosen_location[1]] == piece
      else
        return true if board_array[chosen_location[0]][chosen_location[1]].piece_symbol == piece
      end
    end

    false
  end

  # confirm a player's chosen piece is the one they actually want
  def get_piece_choice_confirm
    puts "Confirm you want to move this piece (y/n)"
    confirm_choice = gets.chomp.downcase
    return confirm_choice
  end

  def get_end_move_confirm(player_end)
    puts "Confirm you want to move this piece to \"#{player_end}\" (y/n)"
    confirm_choice = gets.chomp.downcase
    return confirm_choice
  end

  def handle_confirm_choice(confirm_choice)
    return true if confirm_choice == "y" || confirm_choice == "yes"

    false
  end

  private 

  def prompt_player_location(player_color)
    puts <<-HEREDOC 
#{player_color.upcase}: Choose piece to move (type column then row with no space)...
Example: a1, h3, g8, etc. Or type "draw" to ask for a draw.
    HEREDOC
  end

  def prompt_player_ending_location(player_color)
    puts <<-HEREDOC 
#{player_color.upcase}: Choose location to move to (ex: Example: a1, h3, g8, etc.)
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