require 'colorize'
require_relative 'chess_pieces'
require_relative 'pawn'

# generates chess pieces as objects and holds information about what piece
# a square is holding (if any)
class SquarePieces

  include ChessPieces

  w_pawn1 = Pawn.new(WHITE_PAWN)
  w_pawn2 = Pawn.new(WHITE_PAWN)
  w_pawn3 = Pawn.new(WHITE_PAWN)
  w_pawn4 = Pawn.new(WHITE_PAWN)
  w_pawn5 = Pawn.new(WHITE_PAWN)
  w_pawn6 = Pawn.new(WHITE_PAWN)
  w_pawn7 = Pawn.new(WHITE_PAWN)
  w_pawn8 = Pawn.new(WHITE_PAWN)

  b_pawn1 = Pawn.new(BLACK_PAWN)
  b_pawn2 = Pawn.new(BLACK_PAWN)
  b_pawn3 = Pawn.new(BLACK_PAWN)
  b_pawn4 = Pawn.new(BLACK_PAWN)
  b_pawn5 = Pawn.new(BLACK_PAWN)
  b_pawn6 = Pawn.new(BLACK_PAWN)
  b_pawn7 = Pawn.new(BLACK_PAWN)
  b_pawn8 = Pawn.new(BLACK_PAWN)

  # A column
  @@a1_piece = WHITE_ROOK
  @@a2_piece = w_pawn1.piece_symbol
  @@a3_piece = "   "
  @@a4_piece = "   "
  @@a5_piece = "   "
  @@a6_piece = "   "
  @@a7_piece = b_pawn1.piece_symbol
  @@a8_piece = BLACK_ROOK

  # B column
  @@b1_piece = WHITE_KNIGHT 
  @@b2_piece = w_pawn2.piece_symbol
  @@b3_piece = "   "
  @@b4_piece = "   "
  @@b5_piece = "   "
  @@b6_piece = "   "
  @@b7_piece = b_pawn2.piece_symbol
  @@b8_piece = BLACK_KNIGHT

  # C column
  @@c1_piece = WHITE_BISHOP
  @@c2_piece = w_pawn3.piece_symbol
  @@c3_piece = "   "
  @@c4_piece = "   "
  @@c5_piece = "   "
  @@c6_piece = "   "
  @@c7_piece = b_pawn3.piece_symbol
  @@c8_piece = BLACK_BISHOP

  # D column
  @@d1_piece = WHITE_QUEEN
  @@d2_piece = w_pawn4.piece_symbol
  @@d3_piece = "   "
  @@d4_piece = "   "
  @@d5_piece = "   "
  @@d6_piece = "   "
  @@d7_piece = b_pawn4.piece_symbol
  @@d8_piece = BLACK_QUEEN

  # E column
  @@e1_piece = WHITE_KING
  @@e2_piece = w_pawn5.piece_symbol
  @@e3_piece = "   "
  @@e4_piece = "   "
  @@e5_piece = "   "
  @@e6_piece = "   "
  @@e7_piece = b_pawn5.piece_symbol
  @@e8_piece = BLACK_KING

  # F column
  @@f1_piece = WHITE_BISHOP
  @@f2_piece = w_pawn6.piece_symbol
  @@f3_piece = "   "
  @@f4_piece = "   "
  @@f5_piece = "   "
  @@f6_piece = "   "
  @@f7_piece = b_pawn6.piece_symbol
  @@f8_piece = BLACK_BISHOP

  # G column
  @@g1_piece = WHITE_KNIGHT 
  @@g2_piece = w_pawn7.piece_symbol
  @@g3_piece = "   "
  @@g4_piece = "   "
  @@g5_piece = "   "
  @@g6_piece = "   "
  @@g7_piece = b_pawn7.piece_symbol
  @@g8_piece = BLACK_KNIGHT

  # H column
  @@h1_piece = WHITE_ROOK
  @@h2_piece = w_pawn8.piece_symbol
  @@h3_piece = "   "
  @@h4_piece = "   "
  @@h5_piece = "   "
  @@h6_piece = "   "
  @@h7_piece = b_pawn8.piece_symbol
  @@h8_piece = BLACK_ROOK
end