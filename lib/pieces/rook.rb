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

    up_vertical_moves = get_up_vertical_moves(up_vertical_moves, chess_board, current_location, rook_color)
    down_vertical_moves = get_down_vertical_moves(down_vertical_moves, chess_board, current_location, rook_color)
    left_horizontal_moves = get_left_horizontal_moves(left_horizontal_moves, chess_board, current_location, rook_color)

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
    end

    print "UP-VERT: #{up_vertical_moves}\n"
    print "DOWN-VERT: #{down_vertical_moves}\n"
    print "RIGHT-HORZ: #{right_horizontal_moves}\n"
    print "LEFT-HORZ: #{left_horizontal_moves}\n\n"

    add_moves_to_moves_array(up_vertical_moves, down_vertical_moves, right_horizontal_moves, left_horizontal_moves, moves)

    moves
  end

  private 

  # used to generate possible movement locations along any given direction
  def handle_rook_moves(chess_board, location, movement_direction, count, color)
    if chess_board[location[0]][location[1]] == "   "
      count += 1
    elsif chess_board[location[0]][location[1]].piece_symbol == color ||
      chess_board[location[0]][location[1]].piece_symbol == color ||
      chess_board[location[0]][location[1]].piece_symbol == color ||
      chess_board[location[0]][location[1]].piece_symbol == color ||
      chess_board[location[0]][location[1]].piece_symbol == color ||
      chess_board[location[0]][location[1]].piece_symbol == color

      movement_direction = movement_direction.slice(0, count + 1)
    else
      movement_direction = movement_direction.slice(0, count)
    end

    movement_direction
  end

  # retrieve all posible moves up from the rook's position
  def get_up_vertical_moves(up_vertical_moves, chess_board, current_location, rook_color)
    for i in 1..7
      unless current_location[0] + i > 7 || current_location[0] + i < 0
        up_vertical_moves << [current_location[0] + i, current_location[1]]
      end
    end

    count = 0
    up_vertical_moves.each do |location| 
      if rook_color == " \u2656 "
        up_vertical_moves = handle_rook_moves(chess_board, location, up_vertical_moves, count, " \u265f ".colorize(:black))
      else 
        up_vertical_moves = handle_rook_moves(chess_board, location, up_vertical_moves, count, " \u265f ")
      end
    end

    up_vertical_moves
  end

  # retrieve all posible moves down from the rook's position
  def get_down_vertical_moves(down_vertical_moves, chess_board, current_location, rook_color)
    for i in 1..7
      unless current_location[0] - i > 7 || current_location[0] - i < 0
        down_vertical_moves << [current_location[0] - i, current_location[1]]
      end
    end

    count = 0
    down_vertical_moves.each do |location| 
      if rook_color == " \u2656 "
        down_vertical_moves = handle_rook_moves(chess_board, location, down_vertical_moves, count, " \u265f ".colorize(:black))
      else 
        down_vertical_moves = handle_rook_moves(chess_board, location, down_vertical_moves, count, " \u265f ")
      end
    end

    down_vertical_moves
  end

  # retrieve all posible moves to the left of the rook's position
  def get_left_horizontal_moves(left_horizontal_moves, chess_board, current_location, rook_color)
    for i in 1..7
      unless current_location[1] - i > 7 || current_location[1] - i < 0
        left_horizontal_moves << [current_location[0], current_location[1] - i]
      end
    end

    count = 0
    left_horizontal_moves.each do |location| 
      if rook_color == " \u2656 "
        left_horizontal_moves = handle_rook_moves(chess_board, location, left_horizontal_moves, count, " \u265f ".colorize(:black))
      else
        left_horizontal_moves = handle_rook_moves(chess_board, location, left_horizontal_moves, count, " \u265f ")
      end
    end

    left_horizontal_moves
  end

  # adds all moves grabbed from the 4 directions to the main moves array to return
  def add_moves_to_moves_array(up_vertical_moves, down_vertical_moves, right_horizontal_moves, left_horizontal_moves, moves)
    up_vertical_moves.each do |move|
      moves << move 
    end
    down_vertical_moves.each do |move|
      moves << move 
    end
    right_horizontal_moves.each do |move|
      moves << move 
    end
    left_horizontal_moves.each do |move|
      moves << move 
    end

    moves
  end
end

