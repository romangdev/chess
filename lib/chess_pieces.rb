# frozen_string_literal: true

require 'colorize'

module ChessPieces 
  WHITE_PAWN = " \u2659 "
  WHITE_ROOK = " \u2655 "
  WHITE_KNIGHT = " \u2658 "
  WHITE_BISHOP = " \u2657 "
  WHITE_QUEEN = " \u2655 "
  WHITE_KING = " \u2654 "

  BLACK_PAWN = " \u265f ".colorize(:black)
  BLACK_ROOK = " \u265c ".colorize(:black)
  BLACK_KNIGHT = " \u265e ".colorize(:black)
  BLACK_BISHOP = " \u265d ".colorize(:black)
  BLACK_QUEEN = " \u265b ".colorize(:black)
  BLACK_KING = " \u265a ".colorize(:black)
end