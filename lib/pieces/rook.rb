# frozen_string_literal: true

class Rook
  attr_reader :piece_symbol

  def initialize(piece_symbol)
    @first_move_made = false
    @piece_symbol = piece_symbol
  end

  def generate_moves(current_location, chess_board, rook_color)
    moves = []
    vertical_moves = []
    horizontal_moves = []
    up_vertical_moves = []
    left_horizontal_moves = []
    down_vertical_moves = []
    right_horizontal_moves = []

    for i in 1..7
      unless current_location[0] + i > 7 || current_location[0] + i < 0
        up_vertical_moves << [current_location[0] + i, current_location[1]]
      end
    end

    count = 0
    up_vertical_moves.each do |location| 
      if rook_color == " \u2656 "
        if chess_board[location[0]][location[1]] == "   "
          count += 1
          next
        elsif chess_board[location[0]][location[1]].piece_symbol == " \u265f ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265c ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265e ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265d ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265b ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265fa".colorize(:black)

          up_vertical_moves = up_vertical_moves.slice(0, count + 1)
        else
          up_vertical_moves = up_vertical_moves.slice(0, count)
        end
      end
    end

    for i in 1..7
      unless current_location[0] - i > 7 || current_location[0] - i < 0
        down_vertical_moves << [current_location[0] - i, current_location[1]]
      end
    end

    count = 0
    down_vertical_moves.each do |location| 
      if rook_color == " \u2656 "
        if chess_board[location[0]][location[1]] == "   "
          count += 1
          next
        elsif chess_board[location[0]][location[1]].piece_symbol == " \u265f ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265c ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265e ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265d ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265b ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265fa".colorize(:black)

          down_vertical_moves = down_vertical_moves.slice(0, count + 1)
        else
          down_vertical_moves = down_vertical_moves.slice(0, count)
        end
      end
    end

    for i in 1..7
      unless current_location[1] + i > 7 || current_location[1] + i < 0
        right_horizontal_moves << [current_location[0], current_location[1] + i]
      end
    end

    count = 0
    right_horizontal_moves.each do |location| 
      if rook_color == " \u2656 "
        if chess_board[location[0]][location[1]] == "   "
          count += 1
          next
        elsif chess_board[location[0]][location[1]].piece_symbol == " \u265f ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265c ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265e ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265d ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265b ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265fa".colorize(:black)

          right_horizontal_moves = right_horizontal_moves.slice(0, count + 1)
        else
          right_horizontal_moves = right_horizontal_moves.slice(0, count)
        end
      end
      count += 1
    end

    for i in 1..7
      unless current_location[1] - i > 7 || current_location[1] - i < 0
        left_horizontal_moves << [current_location[0], current_location[1] - i]
      end
    end

    count = 0
    left_horizontal_moves.each do |location| 
      if rook_color == " \u2656 "
        if chess_board[location[0]][location[1]] == "   "
          count += 1
          next
        elsif chess_board[location[0]][location[1]].piece_symbol == " \u265f ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265c ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265e ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265d ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265b ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265fa".colorize(:black)

          left_horizontal_moves = left_horizontal_moves.slice(0, count + 1)
        else
          left_horizontal_moves = left_horizontal_moves.slice(0, count)
        end
      end
      count += 1
    end

    print "UP-VERT: #{up_vertical_moves}\n"
    print "DOWN-VERT: #{down_vertical_moves}\n"
    print "RIGHT-HORZ: #{right_horizontal_moves}\n"
    print "LEFT-HORZ: #{left_horizontal_moves}\n\n"

    up_vertical_moves.each do |move|
      vertical_moves << move 
    end

    down_vertical_moves.each do |move|
      vertical_moves << move 
    end

    right_horizontal_moves.each do |move|
      horizontal_moves << move 
    end

    left_horizontal_moves.each do |move|
      horizontal_moves << move 
    end

    vertical_moves.each do |move|
      moves << move
    end

    horizontal_moves.each do |move|
      moves << move
    end

    # print "VERT: #{vertical_moves}"
    # print "HORIZ: #{horizontal_moves}"

    moves
  end
end