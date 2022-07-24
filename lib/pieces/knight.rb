# frozen_string_literal: true
require "./lib/chess_pieces"

class Knight
  attr_reader :piece_symbol

  def initialize(piece_symbol)
    @piece_symbol = piece_symbol
  end

  def generate_moves(current_location, chess_board, knight_color)
    moves = []
    possible_moves = []

    moves << [current_location[0] + 2, current_location[1] + 1] << [current_location[0] + 2, current_location[1] - 1] <<
    [current_location[0] - 2, current_location[1] + 1] << [current_location[0] - 2, current_location[1] - 1] << [current_location[0] + 1, current_location[1] + 2] <<
    [current_location[0] - 1, current_location[1] + 2] << [current_location[0] - 1, current_location[1] - 2] << [current_location[0] + 1, current_location[1] - 2]

    for i in 0...moves.length
      moves[i] = 'nil' if moves[i][0].negative? || moves[i][1].negative? ||
                                    moves[i][0] > 7 || moves[i][1] > 7
    end

    moves.delete('nil')

    if knight_color == " \u2658 "
      moves.each do |move|
        unless chess_board[move[0]][move[1]] == "   "
          if chess_board[move[0]][move[1]].piece_symbol == " \u2659 " ||
            chess_board[move[0]][move[1]].piece_symbol == " \u2656 " ||
            chess_board[move[0]][move[1]].piece_symbol == " \u2658 " ||
            chess_board[move[0]][move[1]].piece_symbol == " \u2657 " ||
            chess_board[move[0]][move[1]].piece_symbol == " \u2655 " ||
            chess_board[move[0]][move[1]].piece_symbol == " \u2654 "

            move = "nil"
          end
        end
        possible_moves << move
      end
    else
      moves.each do |move|
        unless chess_board[move[0]][move[1]] == "   "
          if chess_board[move[0]][move[1]].piece_symbol == " \u265f ".colorize(:black) ||
            chess_board[move[0]][move[1]].piece_symbol == " \u265c ".colorize(:black) ||
            chess_board[move[0]][move[1]].piece_symbol == " \u265e ".colorize(:black) ||
            chess_board[move[0]][move[1]].piece_symbol == " \u265d ".colorize(:black) ||
            chess_board[move[0]][move[1]].piece_symbol == " \u265b ".colorize(:black) ||
            chess_board[move[0]][move[1]].piece_symbol == " \u265a ".colorize(:black)

            move = "nil"
          end
        end
        possible_moves << move
      end
    end

    possible_moves.delete('nil')


    print possible_moves
    possible_moves
  end
end