require 'colorize'
require_relative 'square_pieces'

class Board < SquarePieces
  attr_accessor :chess_board

  def initialize
    @chess_board = nil
  end

  def generate_board
    @chess_board = [["#{@@a1_piece}".colorize(:background => :magenta), "#{@@b1_piece}".colorize(:background => :light_black),
      "#{@@c1_piece}".colorize(:background => :magenta), "#{@@d1_piece}".colorize(:background => :light_black),
      "#{@@e1_piece}".colorize(:background => :magenta), "#{@@f1_piece}".colorize(:background => :light_black),
      "#{@@g1_piece}".colorize(:background => :magenta), "#{@@h1_piece}".colorize(:background => :light_black)],
    
      ["#{@@a2_piece}".colorize(:background => :light_black), "#{@@b2_piece}".colorize(:background => :magenta),
        "#{@@c2_piece}".colorize(:background => :light_black), "#{@@d2_piece}".colorize(:background => :magenta),
        "#{@@e2_piece}".colorize(:background => :light_black), "#{@@f2_piece}".colorize(:background => :magenta),
        "#{@@g2_piece}".colorize(:background => :light_black), "#{@@h2_piece}".colorize(:background => :magenta)],
      
      ["#{@@a3_piece}".colorize(:background => :magenta), "#{@@b3_piece}".colorize(:background => :light_black),
        "#{@@c3_piece}".colorize(:background => :magenta), "#{@@d3_piece}".colorize(:background => :light_black),
        "#{@@e3_piece}".colorize(:background => :magenta), "#{@@f3_piece}".colorize(:background => :light_black),
        "#{@@g3_piece}".colorize(:background => :magenta), "#{@@h3_piece}".colorize(:background => :light_black)],
        
      ["#{@@a4_piece}".colorize(:background => :light_black), "#{@@b4_piece}".colorize(:background => :magenta),
        "#{@@c4_piece}".colorize(:background => :light_black), "#{@@d4_piece}".colorize(:background => :magenta),
        "#{@@e4_piece}".colorize(:background => :light_black), "#{@@f4_piece}".colorize(:background => :magenta),
        "#{@@g4_piece}".colorize(:background => :light_black), "#{@@h4_piece}".colorize(:background => :magenta)],
      
      ["#{@@a5_piece}".colorize(:background => :magenta), "#{@@b5_piece}".colorize(:background => :light_black),
        "#{@@c5_piece}".colorize(:background => :magenta), "#{@@d5_piece}".colorize(:background => :light_black),
        "#{@@e5_piece}".colorize(:background => :magenta), "#{@@f5_piece}".colorize(:background => :light_black),
        "#{@@g5_piece}".colorize(:background => :magenta), "#{@@h5_piece}".colorize(:background => :light_black)],
        
      ["#{@@a6_piece}".colorize(:background => :light_black), "#{@@b6_piece}".colorize(:background => :magenta),
        "#{@@c6_piece}".colorize(:background => :light_black), "#{@@d6_piece}".colorize(:background => :magenta),
        "#{@@e6_piece}".colorize(:background => :light_black), "#{@@f6_piece}".colorize(:background => :magenta),
        "#{@@g6_piece}".colorize(:background => :light_black), "#{@@h6_piece}".colorize(:background => :magenta)],
          
      ["#{@@a7_piece}".colorize(:background => :magenta), "#{@@b7_piece}".colorize(:background => :light_black),
        "#{@@c7_piece}".colorize(:background => :magenta), "#{@@d7_piece}".colorize(:background => :light_black),
        "#{@@e7_piece}".colorize(:background => :magenta), "#{@@f7_piece}".colorize(:background => :light_black),
        "#{@@g7_piece}".colorize(:background => :magenta), "#{@@h7_piece}".colorize(:background => :light_black)],
            
      ["#{@@a8_piece}".colorize(:background => :light_black), "#{@@b8_piece}".colorize(:background => :magenta),
        "#{@@c8_piece}".colorize(:background => :light_black), "#{@@d8_piece}".colorize(:background => :magenta),
        "#{@@e8_piece}".colorize(:background => :light_black), "#{@@f8_piece}".colorize(:background => :magenta),
        "#{@@g8_piece}".colorize(:background => :light_black), "#{@@h8_piece}".colorize(:background => :magenta)],]
  end

  def display_board 
    for i in 7.downto(0)
      @chess_board[i].each do |element|
        print element
      end
      puts "\n"
    end
  end
end