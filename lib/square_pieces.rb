# frozen_string_literal: true

require 'colorize'
require_relative 'chess_pieces'
require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/king'

# generates chess pieces as objects and holds information about what piece
# a square is holding (if any)
class SquarePieces
  include ChessPieces

  # create objects for all white pieces on board
  w_pawn1 = Pawn.new(WHITE_PAWN)
  w_pawn2 = Pawn.new(WHITE_PAWN)
  w_pawn3 = Pawn.new(WHITE_PAWN)
  w_pawn4 = Pawn.new(WHITE_PAWN)
  w_pawn5 = Pawn.new(WHITE_PAWN)
  w_pawn6 = Pawn.new(WHITE_PAWN)
  w_pawn7 = Pawn.new(WHITE_PAWN)
  w_pawn8 = Pawn.new(WHITE_PAWN)
  w_rook1 = Rook.new(WHITE_ROOK)
  w_rook2 = Rook.new(WHITE_ROOK)
  w_knight1 = Knight.new(WHITE_KNIGHT)
  w_knight2 = Knight.new(WHITE_KNIGHT)
  w_bishop1 = Bishop.new(WHITE_BISHOP)
  w_bishop2 = Bishop.new(WHITE_BISHOP)
  w_queen = Queen.new(WHITE_QUEEN)
  w_king = King.new(WHITE_KING)

  # w_king.checked = true

  # create objects for all black pieces on board
  b_pawn1 = Pawn.new(BLACK_PAWN)
  b_pawn2 = Pawn.new(BLACK_PAWN)
  b_pawn3 = Pawn.new(BLACK_PAWN)
  b_pawn4 = Pawn.new(BLACK_PAWN)
  b_pawn5 = Pawn.new(BLACK_PAWN)
  b_pawn6 = Pawn.new(BLACK_PAWN)
  b_pawn7 = Pawn.new(BLACK_PAWN)
  b_pawn8 = Pawn.new(BLACK_PAWN)
  b_rook1 = Rook.new(BLACK_ROOK)
  b_rook2 = Rook.new(BLACK_ROOK)
  b_knight1 = Knight.new(BLACK_KNIGHT)
  b_knight2 = Knight.new(BLACK_KNIGHT)
  b_bishop1 = Bishop.new(BLACK_BISHOP)
  b_bishop2 = Bishop.new(BLACK_BISHOP)
  b_queen = Queen.new(BLACK_QUEEN)
  b_king = King.new(BLACK_KING)

  # A column
  @@a1_piece = '   '
  @@a2_piece = '   '
  @@a3_piece = '   '
  @@a4_piece = '   '
  @@a5_piece = '   '
  @@a6_piece = '   '
  @@a7_piece = b_pawn1
  @@a8_piece = b_rook1

  # B column
  @@b1_piece = '   '
  @@b2_piece = '   '
  @@b3_piece = '   '
  @@b4_piece = '   '
  @@b5_piece = '   '
  @@b6_piece = '   '
  @@b7_piece = b_pawn2
  @@b8_piece = b_knight1

  # C column
  @@c1_piece = '   '
  @@c2_piece = '   '
  @@c3_piece = '   '
  @@c4_piece = '   '
  @@c5_piece = '   '
  @@c6_piece = '   '
  @@c7_piece = b_pawn3
  @@c8_piece = b_bishop1

  # D column
  @@d1_piece = w_pawn6
  @@d2_piece = w_pawn4
  @@d3_piece = b_bishop1
  @@d4_piece = '   '
  @@d5_piece = '   '
  @@d6_piece = '   '
  @@d7_piece = b_pawn4
  @@d8_piece = b_queen

  # E column
  @@e1_piece = w_king
  @@e2_piece = '   '
  @@e3_piece = '   '
  @@e4_piece = '   '
  @@e5_piece = '   '
  @@e6_piece = '   '
  @@e7_piece = b_pawn5
  @@e8_piece = b_king

  # F column
  @@f1_piece = w_pawn6
  @@f2_piece = w_pawn6
  @@f3_piece = b_bishop1
  @@f4_piece = '   '
  @@f5_piece = '   '
  @@f6_piece = '   '
  @@f7_piece = b_pawn6
  @@f8_piece = b_bishop2

  # G column
  @@g1_piece = '   '
  @@g2_piece = '   '
  @@g3_piece = '   '
  @@g4_piece = '   '
  @@g5_piece = '   '
  @@g6_piece = '   '
  @@g7_piece = b_pawn7
  @@g8_piece = b_knight2

  # H column
  @@h1_piece = '   '
  @@h2_piece = '   '
  @@h3_piece = '   '
  @@h4_piece = '   '
  @@h5_piece = '   '
  @@h6_piece = '   '
  @@h7_piece = b_pawn8
  @@h8_piece = b_rook2
end
