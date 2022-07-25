# frozen_string_literal: true
require "./lib/chess_pieces"

class Pawn
  attr_accessor :first_move_made
  attr_reader :piece_symbol

  include ChessPieces

  def initialize(piece_symbol)
    @first_move_made = false
    @piece_symbol = piece_symbol
  end

  # generates an array of all possible moves for a pawn piece
  def generate_moves(current_location, chess_board, pawn_color) 
    moves = []
    moves = check_first_move(moves, current_location, pawn_color, chess_board)
    moves = check_capturable_pieces(moves, current_location, chess_board, pawn_color)
    if pawn_color == WHITE_PAWN
      moves = white_one_square_move(chess_board, current_location, moves)
    else
      moves = black_one_square_move(chess_board, current_location, moves)
    end
    moves
  end

  private

  # handles usual one square forward move for white pawn
  def white_one_square_move(chess_board, current_location, moves)
    if chess_board[current_location[0] + 1][current_location[1]] == "   "
      moves << [current_location[0] + 1, current_location[1]]
    end

    moves
  end

  # handles usual one square forward move for black pawn
  def black_one_square_move(chess_board, current_location, moves)
    if chess_board[current_location[0] - 1][current_location[1]] == "   "
      moves << [current_location[0] - 1, current_location[1]]
    end
    
    moves
  end

  # checks to see if pawn is at first move, and allows a double square move forward if so
  # movement is in different direction depending on pawn color
  def check_first_move(moves, current_location, pawn_color, chess_board)
    
    if pawn_color == WHITE_PAWN
      if self.first_move_made == false && chess_board[current_location[0] + 2][current_location[1]] == "   " &&
        chess_board[current_location[0] + 1][current_location[1]] == "   "

        moves << [current_location[0] + 2, current_location[1]]
        self.first_move_made = true
      end
    else 
      if self.first_move_made == false && chess_board[current_location[0] - 2][current_location[1]] == "   " &&
        chess_board[current_location[0] - 1][current_location[1]] == "   "

        moves << [current_location[0] - 2, current_location[1]] 
        self.first_move_made = true
      end
    end
    
    moves
  end

  # checks to see if pawn can capture any diagonally adjacent pieces
  # check is in different direction depending on pawn color
  def check_capturable_pieces(moves, current_location, chess_board, pawn_color)
    if pawn_color == WHITE_PAWN
      right_diagonal = chess_board[current_location[0] + 1][current_location[1] + 1]
      left_diagonal = chess_board[current_location[0] + 1][current_location[1] - 1]
    else 
      right_diagonal = chess_board[current_location[0] - 1][current_location[1] - 1]
      left_diagonal = chess_board[current_location[0] - 1][current_location[1] + 1]
    end

    handle_diagonals(right_diagonal, left_diagonal, moves, current_location)
  end

  # holds methods that handle diagonals for both white pawns and black pawns 
  def handle_diagonals(right_diagonal, left_diagonal, moves, current_location)
    if self.piece_symbol == WHITE_PAWN
      moves = handle_white_diagonals(right_diagonal, left_diagonal, current_location, moves)
    else
      moves = handle_black_diagonals(right_diagonal, left_diagonal, current_location, moves)
    end
    moves
  end

  # adds a diagonal piece location to a white pawn's move array if capture is possible
  def handle_white_diagonals(right_diagonal, left_diagonal, current_location, moves)
    check = white_check_diagonal(right_diagonal)
    moves << [current_location[0] + 1, current_location[1] + 1] if check

    check = white_check_diagonal(left_diagonal)
    moves << [current_location[0] + 1, current_location[1] - 1] if check

    moves
  end

  # adds a diagonal piece location to a black pawn's move array if capture is possible
  def handle_black_diagonals(right_diagonal, left_diagonal, current_location, moves)
    check = black_check_diagonal(right_diagonal)
    moves << [current_location[0] - 1, current_location[1] - 1] if check

    check = black_check_diagonal(left_diagonal)
    moves << [current_location[0] - 1, current_location[1] + 1] if check

    moves
  end

  # checks if a diagonal piece adjacent to white pawn is a piece of opposite color
  def white_check_diagonal(diagonal)
    unless diagonal == nil 
      if diagonal != "   " && (diagonal.piece_symbol == BLACK_PAWN ||
        diagonal.piece_symbol == BLACK_ROOK || diagonal.piece_symbol == BLACK_KNIGHT ||
        diagonal.piece_symbol == BLACK_BISHOP || diagonal.piece_symbol == BLACK_QUEEN ||
        diagonal.piece_symbol == BLACK_KING)

        return true
      end
    end

    false
  end

  # checks if a diagonal piece adjacent to black pawn is a piece of opposite color
  def black_check_diagonal(diagonal)
    unless diagonal == nil 
      if diagonal != "   " && (diagonal.piece_symbol == WHITE_PAWN ||
        diagonal.piece_symbol == WHITE_ROOK || diagonal.piece_symbol == WHITE_QUEEN ||
        diagonal.piece_symbol == WHITE_KNIGHT || diagonal.piece_symbol == WHITE_KING ||
        diagonal.piece_symbol == WHITE_BISHOP)

        return true
      end
    end

    false
  end
end
