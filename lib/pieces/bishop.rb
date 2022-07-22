# frozen_string_literal: true

class Bishop
  attr_reader :piece_symbol

  def initialize(piece_symbol)
    @piece_symbol = piece_symbol
  end

  def generate_moves(current_location, chess_board, bishop_color)
    moves = []
    up_right_moves = []
    up_left_moves = []
    down_right_moves = []
    down_left_moves = []

    up_right_moves = handle_up_right_moves(up_right_moves, current_location, bishop_color, chess_board)

    print "UP-RIGHT: #{up_right_moves}\n"
  end

  private 

  # get possible moves a bishop can make going a given direction (cut off non-possible moves)
  def get_bishop_direction_moves(chess_board, location, move_direction, color)
    count = 0
    move_direction.each do |location| 
      if chess_board[location[0]][location[1]] == "   "
        count += 1
        next
      elsif chess_board[location[0]][location[1]].piece_symbol == color ||
        chess_board[location[0]][location[1]].piece_symbol == color ||
        chess_board[location[0]][location[1]].piece_symbol == color ||
        chess_board[location[0]][location[1]].piece_symbol == color ||
        chess_board[location[0]][location[1]].piece_symbol == color ||
        chess_board[location[0]][location[1]].piece_symbol == color

        move_direction = move_direction.slice(0, count + 1)
      else
        move_direction = move_direction.slice(0, count)
      end
    end

    move_direction
  end

  # handle grabbing all possible upwards vertical moves depending on rook color
  def handle_up_right_moves(up_right_moves, current_location, bishop_color, chess_board)
    for i in 1..7
      unless current_location[0] + i > 7 || current_location[0] + i < 0 ||
            current_location[1] + i > 7 || current_location[1] + i < 0

        up_right_moves << [current_location[0] + i, current_location[1] + i]
      end
    end
    if bishop_color == " \u2656 "
      up_right_moves = get_bishop_direction_moves(chess_board, current_location, up_right_moves, " \u265f ".colorize(:black))
    else
      up_right_moves = get_bishop_direction_moves(chess_board, current_location, up_right_moves, " \u265f ")
    end

    up_right_moves
  end

  # handle grabbing all possible downwards vertical moves depending on rook color
  def handle_down_vertical_moves(down_vertical_moves, current_location, rook_color, chess_board)
    for i in 1..7
      unless current_location[0] - i > 7 || current_location[0] - i < 0
        down_vertical_moves << [current_location[0] - i, current_location[1]]
      end
    end
    if rook_color == " \u2656 "
      down_vertical_moves = get_rook_direction_moves(chess_board, current_location, down_vertical_moves, " \u265f ".colorize(:black))
    else
      down_vertical_moves = get_rook_direction_moves(chess_board, current_location, down_vertical_moves, " \u265f ")
    end

    down_vertical_moves
  end

  # handle grabbing all possible right horizontal moves depending on rook color
  def handle_right_horizontal_moves(right_horizontal_moves, current_location, rook_color, chess_board)
    for i in 1..7
      unless current_location[1] + i > 7 || current_location[1] + i < 0
        right_horizontal_moves << [current_location[0], current_location[1] + i]
      end
    end
    if rook_color == " \u2656 "
      right_horizontal_moves = get_rook_direction_moves(chess_board, current_location, right_horizontal_moves, " \u265f ".colorize(:black))
    else
      right_horizontal_moves = get_rook_direction_moves(chess_board, current_location, right_horizontal_moves, " \u265f ")
    end

    right_horizontal_moves
  end

  # handle grabbing all possible left horizontal moves depending on rook color
  def handle_left_horizontal_moves(left_horizontal_moves, current_location, rook_color, chess_board)
    for i in 1..7
      unless current_location[1] - i > 7 || current_location[1] - i < 0
        left_horizontal_moves << [current_location[0], current_location[1] - i]
      end
    end
    if rook_color == " \u2656 "
      left_horizontal_moves= get_rook_direction_moves(chess_board, current_location, left_horizontal_moves, " \u265f ".colorize(:black))
    else
      left_horizontal_moves= get_rook_direction_moves(chess_board, current_location, left_horizontal_moves, " \u265f ")
    end

    left_horizontal_moves
  end
end