# frozen_string_literal: true

require 'colorize'
require_relative 'square_pieces'

class Board < SquarePieces
  attr_accessor :chess_board

  def initialize
    @chess_board = nil
  end

  # generates 8x8 array which is used to display chess board
  def generate_board
    @chess_board = [[@@a1_piece, @@b1_piece, @@c1_piece, @@d1_piece,
                    @@e1_piece, @@f1_piece, @@g1_piece, @@h1_piece],
                  
                    [@@a2_piece, @@b2_piece, @@c2_piece, @@d2_piece,
                      @@e2_piece, @@f2_piece, @@g2_piece, @@h2_piece],
                    
                    [@@a3_piece, @@b3_piece, @@c3_piece, @@d3_piece,
                      @@e3_piece, @@f3_piece, @@g3_piece, @@h3_piece],
                      
                    [@@a4_piece, @@b4_piece, @@c4_piece, @@d4_piece,
                      @@e4_piece, @@f4_piece, @@g4_piece, @@h4_piece],
                    
                    [@@a5_piece, @@b5_piece, @@c5_piece, @@d5_piece,
                      @@e5_piece, @@f5_piece, @@g5_piece, @@h5_piece],
                      
                    [@@a6_piece, @@b6_piece, @@c6_piece, @@d6_piece,
                      @@e6_piece, @@f6_piece, @@g6_piece, @@h6_piece],
                        
                    [@@a7_piece, @@b7_piece, @@c7_piece, @@d7_piece,
                      @@e7_piece, @@f7_piece, @@g7_piece, @@h7_piece],
                          
                    [@@a8_piece, @@b8_piece, @@c8_piece, @@d8_piece,
                      @@e8_piece, @@f8_piece, @@g8_piece, @@h8_piece]]
  end

  # displays the full generated chess board with row/column references
  def display_board(player_choice = [10, 10])
    for i in 7.downto(0)
      print "#{i + 1} "
      n = 0
      if i.odd?
        even_row_display(i, n, player_choice)
      else
        odd_row_display(i, n, player_choice) 
      end
      puts "\n"
    end
    puts "   a  b  c  d  e  f  g  h"
  end

  private 

  # sub-method to display even chess board row (used in #display_board)
  def even_row_display(i, n, player_choice)
    while n <= 7
      if n.even?
        show_light_black_squares(player_choice, i, n)
      else
        show_magenta_squares(player_choice, i, n)
      end
      n += 1
    end 
  end

  # sub-method to display odd chess board row (used in #display_board)
  def odd_row_display(i, n, player_choice)
    while n <= 7 
      if n.even? 
        show_magenta_squares(player_choice, i, n)
      else
        show_light_black_squares(player_choice, i, n)
      end
      n += 1
    end  
  end

  # sub-sub-method to show light black squares with any highlighted square included
  def show_light_black_squares(player_choice, i, n)
    if player_choice[0] == i && player_choice[1] == n
      highlight_initial_location(player_choice)
    else
      print @chess_board[i][n].colorize(:background => :light_black)
    end
  end

  # sub-sub-method to show magenta squares with any highlighted square included
  def show_magenta_squares(player_choice, i, n)
    if player_choice[0] == i && player_choice[1] == n
      highlight_initial_location(player_choice)
    else
      print @chess_board[i][n].colorize(:background => :magenta)
    end
  end

  # sub-sub-sub-method used to highlight player's location of choice
  # found in the individual odd/even colored square display methods
  def highlight_initial_location(player_choice)
    print @chess_board[player_choice[0]][player_choice[1]].colorize(:background => :light_green)
  end
end