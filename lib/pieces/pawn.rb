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

    if self.piece_symbol == " \u2659 "
      white_check_right_diagonal(right_diagonal, moves, current_location)
      white_check_left_diagonal(left_diagonal, moves, current_location)
    else
      black_check_right_diagonal(right_diagonal, moves, current_location)
      black_check_left_diagonal(left_diagonal, moves, current_location)
    end
    moves
  end

  def white_check_right_diagonal(right_diagonal, moves, current_location)
    if right_diagonal != "   " && (right_diagonal.piece_symbol == " \u265f ".colorize(:black) ||
      right_diagonal.piece_symbol == " \u265c ".colorize(:black) || right_diagonal.piece_symbol == " \u265e ".colorize(:black) ||
      right_diagonal.piece_symbol == " \u265d ".colorize(:black) || right_diagonal.piece_symbol == " \u265b ".colorize(:black)||
      right_diagonal.piece_symbol == " \u265a ".colorize(:black))

      moves << [current_location[0] + 1, current_location[1] + 1]
      moves
    end
  end

  def white_check_left_diagonal(left_diagonal, moves, current_location)
    if left_diagonal != "   " && (left_diagonal.piece_symbol == " \u265f ".colorize(:black) ||
      left_diagonal.piece_symbol == " \u265c ".colorize(:black) || left_diagonal.piece_symbol == " \u265e ".colorize(:black) ||
      left_diagonal.piece_symbol == " \u265d ".colorize(:black) || left_diagonal.piece_symbol == " \u265b ".colorize(:black) ||
      left_diagonal.piece_symbol == " \u265a ".colorize(:black))

      moves << [current_location[0] + 1, current_location[1] - 1]
      moves
    end
  end

  def black_check_right_diagonal(right_diagonal, moves, current_location)
    if right_diagonal != "   " && (right_diagonal.piece_symbol == " \u265f " ||
      right_diagonal.piece_symbol == " \u265c " || right_diagonal.piece_symbol == " \u265e " ||
      right_diagonal.piece_symbol == " \u265d " || right_diagonal.piece_symbol == " \u265b "||
      right_diagonal.piece_symbol == " \u265a ")

      moves << [current_location[0] + 1, current_location[1] + 1]
      moves
    end
  end

  def black_check_left_diagonal(left_diagonal, moves, current_location)
    if left_diagonal != "   " && (left_diagonal.piece_symbol == " \u265f " ||
      left_diagonal.piece_symbol == " \u265c " || left_diagonal.piece_symbol == " \u265e " ||
      left_diagonal.piece_symbol == " \u265d " || left_diagonal.piece_symbol == " \u265b "||
      left_diagonal.piece_symbol == " \u265a ")

      moves << [current_location[0] + 1, current_location[1] - 1]
      moves
    end
  end
end
