# frozen_string_literal: true

class Pawn
  attr_accessor :first_move_made
  attr_reader :piece_symbol

  def initialize(piece_symbol)
    @first_move_made = false
    @piece_symbol = piece_symbol
  end

  # generates an array of all possible moves for a pawn piece
  def generate_moves(current_location, chess_board, pawn_color) 
    moves = []
    moves = check_first_move(moves, current_location, pawn_color, chess_board)
    moves = check_capturable_pieces(moves, current_location, chess_board, pawn_color)
    if pawn_color == " \u2659 "
      moves = white_one_square_move(chess_board, current_location, moves)
    else
      moves = black_one_square_move(chess_board, current_location, moves)
    end
    print moves
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
    
    if pawn_color == " \u2659 "
      if self.first_move_made == false && chess_board[current_location[0] + 2][current_location[1]] == "   " &&
        chess_board[current_location[0] + 1][current_location[1]] == "   "

        moves << [current_location[0] + 2, current_location[1]]
        self.first_move_made = true
      end
    else 
      if self.first_move_made == false && chess_board[current_location[0] - 2][current_location[1]] == "   " &&
        chess_board[current_location[0] + 1][current_location[1]] == "   "

        moves << [current_location[0] - 2, current_location[1]] 
        self.first_move_made = true
      end
    end
    
    moves
  end

  # checks to see if pawn can capture any diagonally adjacent pieces
  # check is in different direction depending on pawn color
  def check_capturable_pieces(moves, current_location, chess_board, pawn_color)
    if pawn_color == " \u2659 "
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
    if self.piece_symbol == " \u2659 "
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
    if diagonal != "   " && (diagonal.piece_symbol == " \u265f ".colorize(:black) ||
      diagonal.piece_symbol == " \u265c ".colorize(:black) || diagonal.piece_symbol == " \u265e ".colorize(:black) ||
      diagonal.piece_symbol == " \u265d ".colorize(:black) || diagonal.piece_symbol == " \u265b ".colorize(:black)||
      diagonal.piece_symbol == " \u265a ".colorize(:black))

      return true
    end

    false
  end

  # checks if a diagonal piece adjacent to black pawn is a piece of opposite color
  def black_check_diagonal(diagonal)
    if diagonal != "   " && (diagonal.piece_symbol == " \u265f " ||
      diagonal.piece_symbol == " \u265c " || diagonal.piece_symbol == " \u265e " ||
      diagonal.piece_symbol == " \u265d " || diagonal.piece_symbol == " \u265b "||
      diagonal.piece_symbol == " \u265a ")

      return true
    end

    false
  end
end
