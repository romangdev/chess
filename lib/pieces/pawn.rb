# frozen_string_literal: true

class Pawn
  attr_accessor :first_move_made
  attr_reader :piece_symbol

  def initialize(piece_symbol)
    @first_move_made = false
    @piece_symbol = piece_symbol
  end

  def generate_moves(current_location, chess_board = nil) 
    moves = []
    moves = check_first_move(moves, current_location)
    unless chess_board.nil?
      moves = check_capturable_pieces(moves, current_location, chess_board)
    end
    moves << [current_location[0] + 1, current_location[1]]
    print moves
    moves
  end

  private

  def check_first_move(moves, current_location)
    moves << [current_location[0] + 2, current_location[1]] if self.first_move_made == false 
    moves
  end

  def check_capturable_pieces(moves, current_location, chess_board)
    right_diagonal = chess_board[current_location[0] + 1][current_location[1] + 1]
    left_diagonal = chess_board[current_location[0] + 1][current_location[1] - 1]

    handle_diagonals(right_diagonal, left_diagonal, moves, current_location)
  end

  def handle_diagonals(right_diagonal, left_diagonal, moves, current_location)
    if self.piece_symbol == " \u2659 "
      check = white_check_diagonal(right_diagonal)
      moves << [current_location[0] + 1, current_location[1] + 1] if check

      check = white_check_diagonal(left_diagonal)
      moves << [current_location[0] + 1, current_location[1] - 1] if check
    else
      check = black_check_diagonal(right_diagonal)
      moves << [current_location[0] + 1, current_location[1] + 1] if check

      check = black_check_diagonal(left_diagonal)
      moves << [current_location[0] + 1, current_location[1] - 1] if check
    end
    moves
  end

  def white_check_diagonal(diagonal)
    if diagonal != "   " && (diagonal.piece_symbol == " \u265f ".colorize(:black) ||
      diagonal.piece_symbol == " \u265c ".colorize(:black) || diagonal.piece_symbol == " \u265e ".colorize(:black) ||
      diagonal.piece_symbol == " \u265d ".colorize(:black) || diagonal.piece_symbol == " \u265b ".colorize(:black)||
      diagonal.piece_symbol == " \u265a ".colorize(:black))

      return true
    end

    false
  end

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
