# frozen_string_literal: true
require "./lib/chess_pieces"

class Queen
  attr_reader :piece_symbol

  include ChessPieces

  WHITE_PIECES = [WHITE_PAWN,
                  WHITE_ROOK,
                  WHITE_KNIGHT,
                  WHITE_BISHOP,
                  WHITE_QUEEN,
                  WHITE_KING]

  BLACK_PIECES = [BLACK_PAWN,
                  BLACK_ROOK,
                  BLACK_KNIGHT,
                  BLACK_BISHOP,
                  BLACK_QUEEN,
                  BLACK_KING]

  def initialize(piece_symbol)
    @piece_symbol = piece_symbol
  end

  def generate_moves(current_location, chess_board, queen_color)
    moves = []
    up_vertical_moves = []
    left_horizontal_moves = []
    down_vertical_moves = []
    right_horizontal_moves = []
    up_right_moves = []
    up_left_moves = []
    down_right_moves = []
    down_left_moves = []

    up_vertical_moves = handle_up_vertical_moves(up_vertical_moves, current_location, queen_color, chess_board)
    down_vertical_moves = handle_down_vertical_moves(down_vertical_moves, current_location, queen_color, chess_board)
    right_horizontal_moves = handle_right_horizontal_moves(right_horizontal_moves, current_location, queen_color, chess_board)
    left_horizontal_moves = handle_left_horizontal_moves(left_horizontal_moves, current_location, queen_color, chess_board)
    up_right_moves = handle_up_right_moves(up_right_moves, current_location, queen_color, chess_board)
    up_left_moves = handle_up_left_moves(up_left_moves, current_location, queen_color, chess_board)
    down_right_moves = handle_down_right_moves(down_right_moves, current_location, queen_color, chess_board)
    down_left_moves = handle_down_left_moves(down_left_moves, current_location, queen_color, chess_board)

    add_straight_moves_to_main_array(up_vertical_moves, down_vertical_moves, right_horizontal_moves, left_horizontal_moves, moves)
    add_diagonal_moves_to_main_array(up_right_moves, down_right_moves, up_left_moves, down_left_moves, moves)

    moves
  end

  private

  # add all straight moves from each direction into main moves array
  def add_straight_moves_to_main_array(up_vert, down_vert, right_side, left_side, moves)
    moves << up_vert << down_vert << right_side << left_side
  end

  # add all diagonal moves from each direction into main moves array
  def add_diagonal_moves_to_main_array(up_right, down_right, down_left, up_left, moves)
    moves << up_right << down_right << down_left << up_left
  end

   # get possible moves the rook can make going a given direction (cut off non-possible moves)
  def get_queen_direction_moves(chess_board, location, move_direction, color)
    count = 0
    if color == BLACK_QUEEN
      move_direction.each do |location| 
        if chess_board[location[0]][location[1]] == "   "
          count += 1
          next
        elsif BLACK_PIECES.include? chess_board[location[0]][location[1]].piece_symbol
          move_direction = move_direction.slice(0, count + 1)
        else
          move_direction = move_direction.slice(0, count)
        end
      end
    else 
      move_direction.each do |location| 
        if chess_board[location[0]][location[1]] == "   "
          count += 1
          next
        elsif WHITE_PIECES.include? chess_board[location[0]][location[1]].piece_symbol 
          move_direction = move_direction.slice(0, count + 1)
        else
          move_direction = move_direction.slice(0, count)
        end
      end
    end

    move_direction
  end

  # handle grabbing all possible upwards vertical moves depending on rook color
  def handle_up_vertical_moves(up_vertical_moves, current_location, queen_color, chess_board)
    for i in 1..7
      unless current_location[0] + i > 7 || current_location[0] + i < 0
        up_vertical_moves << [current_location[0] + i, current_location[1]]
      end
    end
    if queen_color == WHITE_QUEEN
      up_vertical_moves = get_queen_direction_moves(chess_board, current_location, up_vertical_moves, BLACK_QUEEN)
    else
      up_vertical_moves = get_queen_direction_moves(chess_board, current_location, up_vertical_moves, WHITE_QUEEN)
    end

    up_vertical_moves
  end

  # handle grabbing all possible downwards vertical moves depending on rook color
  def handle_down_vertical_moves(down_vertical_moves, current_location, queen_color, chess_board)
    for i in 1..7
      unless current_location[0] - i > 7 || current_location[0] - i < 0
        down_vertical_moves << [current_location[0] - i, current_location[1]]
      end
    end
    if queen_color == WHITE_QUEEN
      down_vertical_moves = get_queen_direction_moves(chess_board, current_location, down_vertical_moves, BLACK_QUEEN)
    else
      down_vertical_moves = get_queen_direction_moves(chess_board, current_location, down_vertical_moves, WHITE_QUEEN)
    end

    down_vertical_moves
  end

  # handle grabbing all possible right horizontal moves depending on rook color
  def handle_right_horizontal_moves(right_horizontal_moves, current_location, queen_color, chess_board)
    for i in 1..7
      unless current_location[1] + i > 7 || current_location[1] + i < 0
        right_horizontal_moves << [current_location[0], current_location[1] + i]
      end
    end
    if queen_color == WHITE_QUEEN
      right_horizontal_moves = get_queen_direction_moves(chess_board, current_location, right_horizontal_moves, BLACK_QUEEN)
    else
      right_horizontal_moves = get_queen_direction_moves(chess_board, current_location, right_horizontal_moves, WHITE_QUEEN)
    end

    right_horizontal_moves
  end

  # handle grabbing all possible left horizontal moves depending on rook color
  def handle_left_horizontal_moves(left_horizontal_moves, current_location, queen_color, chess_board)
    for i in 1..7
      unless current_location[1] - i > 7 || current_location[1] - i < 0
        left_horizontal_moves << [current_location[0], current_location[1] - i]
      end
    end
    if queen_color == WHITE_QUEEN
      left_horizontal_moves= get_queen_direction_moves(chess_board, current_location, left_horizontal_moves, BLACK_QUEEN)
    else
      left_horizontal_moves= get_queen_direction_moves(chess_board, current_location, left_horizontal_moves, WHITE_QUEEN)
    end

    left_horizontal_moves
  end

   # get possible moves a bishop can make going a given direction (cut off non-possible moves)
  def get_bishop_direction_moves(chess_board, location, move_direction, color)
    count = 0
    if color == BLACK_QUEEN
      move_direction.each do |location| 
        if chess_board[location[0]][location[1]] == "   "
          count += 1
          next
        elsif BLACK_PIECES.include? chess_board[location[0]][location[1]].piece_symbol
          move_direction = move_direction.slice(0, count + 1)
        else
          move_direction = move_direction.slice(0, count)
        end
      end
    else
      move_direction.each do |location| 
        if chess_board[location[0]][location[1]] == "   "
          count += 1
          next
        elsif WHITE_PIECES.include? chess_board[location[0]][location[1]].piece_symbol
          move_direction = move_direction.slice(0, count + 1)
        else
          move_direction = move_direction.slice(0, count)
        end
      end
    end
    
    move_direction
  end

  # handle grabbing all possible up and rightwards moves depending on bishop color
  def handle_up_right_moves(up_right_moves, current_location, queen_color, chess_board)
    for i in 1..7
      unless current_location[0] + i > 7 || current_location[1] + i > 7
        up_right_moves << [current_location[0] + i, current_location[1] + i]
      end
    end
    if queen_color == WHITE_QUEEN
      up_right_moves = get_queen_direction_moves(chess_board, current_location, up_right_moves, BLACK_QUEEN)
    else
      up_right_moves = get_queen_direction_moves(chess_board, current_location, up_right_moves, WHITE_QUEEN)
    end

    up_right_moves
  end

  # handle grabbing all possible down and rightwards moves depending on bishop color
  def handle_down_right_moves(down_right_moves, current_location, queen_color, chess_board)
    for i in 1..7
      unless current_location[0] - i < 0 || current_location[1] + i > 7      
        down_right_moves << [current_location[0] - i, current_location[1] + i]
      end
    end
    if queen_color == WHITE_QUEEN
      down_right_moves = get_queen_direction_moves(chess_board, current_location, down_right_moves, BLACK_QUEEN)
    else
      down_right_moves = get_queen_direction_moves(chess_board, current_location, down_right_moves, WHITE_QUEEN)
    end

    down_right_moves
  end

  # handle grabbing all possible down and leftwards moves depending on bishop color
  def handle_down_left_moves(down_left_moves, current_location, queen_color, chess_board)
    for i in 1..7
      unless current_location[0] - i < 0 || current_location[1] - i < 0       
        down_left_moves << [current_location[0] - i, current_location[1] - i]
      end
    end
    if queen_color == WHITE_QUEEN
      down_left_moves = get_queen_direction_moves(chess_board, current_location, down_left_moves, BLACK_QUEEN)
    else
      down_left_moves = get_queen_direction_moves(chess_board, current_location, down_left_moves, WHITE_QUEEN)
    end

    down_left_moves
  end

  # handle grabbing all possible up and leftwards moves depending on bishop color
  def handle_up_left_moves(up_left_moves, current_location, queen_color, chess_board)
    for i in 1..7
      unless current_location[0] + i > 7 || current_location[1] - i < 0    
        up_left_moves << [current_location[0] + i, current_location[1] - i]
      end
    end
    if queen_color == WHITE_QUEEN
      up_left_moves = get_queen_direction_moves(chess_board, current_location, up_left_moves, BLACK_QUEEN)
    else
      up_left_moves = get_queen_direction_moves(chess_board, current_location, up_left_moves, WHITE_QUEEN)
    end

    up_left_moves
  end
end