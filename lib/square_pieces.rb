require 'colorize'

class SquarePieces

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

  @@a1_piece = WHITE_ROOK
  @@a2_piece = WHITE_PAWN
  @@a3_piece = "   "
  @@a4_piece = "   "
  @@a5_piece = "   "
  @@a6_piece = "   "
  @@a7_piece = BLACK_PAWN
  @@a8_piece = BLACK_ROOK

  @@b1_piece = WHITE_KNIGHT 
  @@b2_piece = WHITE_PAWN
  @@b3_piece = "   "
  @@b4_piece = "   "
  @@b5_piece = "   "
  @@b6_piece = "   "
  @@b7_piece = BLACK_PAWN
  @@b8_piece = BLACK_KNIGHT

  @@c1_piece = WHITE_BISHOP
  @@c2_piece = WHITE_PAWN
  @@c3_piece = "   "
  @@c4_piece = "   "
  @@c5_piece = "   "
  @@c6_piece = "   "
  @@c7_piece = BLACK_PAWN
  @@c8_piece = BLACK_BISHOP

  @@d1_piece = WHITE_QUEEN
  @@d2_piece = WHITE_PAWN
  @@d3_piece = "   "
  @@d4_piece = "   "
  @@d5_piece = "   "
  @@d6_piece = "   "
  @@d7_piece = BLACK_PAWN
  @@d8_piece = BLACK_KING

  @@e1_piece = WHITE_KING
  @@e2_piece = WHITE_PAWN
  @@e3_piece = "   "
  @@e4_piece = "   "
  @@e5_piece = "   "
  @@e6_piece = "   "
  @@e7_piece = BLACK_PAWN
  @@e8_piece = BLACK_QUEEN

  @@f1_piece = WHITE_BISHOP
  @@f2_piece = WHITE_PAWN
  @@f3_piece = "   "
  @@f4_piece = "   "
  @@f5_piece = "   "
  @@f6_piece = "   "
  @@f7_piece = BLACK_PAWN
  @@f8_piece = BLACK_BISHOP

  @@g1_piece = WHITE_KNIGHT 
  @@g2_piece = WHITE_PAWN
  @@g3_piece = "   "
  @@g4_piece = "   "
  @@g5_piece = "   "
  @@g6_piece = "   "
  @@g7_piece = BLACK_PAWN
  @@g8_piece = BLACK_KNIGHT

  @@h1_piece = WHITE_ROOK
  @@h2_piece = WHITE_PAWN
  @@h3_piece = "   "
  @@h4_piece = "   "
  @@h5_piece = "   "
  @@h6_piece = "   "
  @@h7_piece = BLACK_PAWN
  @@h8_piece = BLACK_ROOK
end