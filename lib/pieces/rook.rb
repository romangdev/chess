# frozen_string_literal: true
require "./lib/chess_pieces"

class Rook
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
    @first_move_made = false
    @piece_symbol = piece_symbol
  end

  # generate all possible moves a rook can make at a given position on board
  def generate_moves(current_location, chess_board, rook_color)
    moves = []
    up_vertical_moves = []
    left_horizontal_moves = []
    down_vertical_moves = []
    right_horizontal_moves = []
    @first_move_made = true

    up_vertical_moves = handle_up_vertical_moves(up_vertical_moves, current_location, rook_color, chess_board)
    down_vertical_moves = handle_down_vertical_moves(down_vertical_moves, current_location, rook_color, chess_board)
    right_horizontal_moves = handle_right_horizontal_moves(right_horizontal_moves, current_location, rook_color, chess_board)
    left_horizontal_moves = handle_left_horizontal_moves(left_horizontal_moves, current_location, rook_color, chess_board)

    add_moves_to_main_array(up_vertical_moves, down_vertical_moves, right_horizontal_moves, left_horizontal_moves, moves)

    moves
  end

  private 

  # add all moves from each direction into main moves array
  def add_moves_to_main_array(up_vert, down_vert, right_side, left_side, moves)
    moves << up_vert << down_vert << right_side << left_side
  end

  # get possible moves the rook can make going a given direction (cut off non-possible moves)
  def get_rook_direction_moves(chess_board, location, move_direction, color)
    count = 0
    if color == BLACK_ROOK
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
  def handle_up_vertical_moves(up_vertical_moves, current_location, rook_color, chess_board)
    for i in 1..7
      unless current_location[0] + i > 7 || current_location[0] + i < 0
        up_vertical_moves << [current_location[0] + i, current_location[1]]
      end
    end
    if rook_color == WHITE_ROOK
      up_vertical_moves = get_rook_direction_moves(chess_board, current_location, up_vertical_moves, BLACK_ROOK)
    else
      up_vertical_moves = get_rook_direction_moves(chess_board, current_location, up_vertical_moves, WHITE_ROOK)
    end

    up_vertical_moves
  end

  # handle grabbing all possible downwards vertical moves depending on rook color
  def handle_down_vertical_moves(down_vertical_moves, current_location, rook_color, chess_board)
    for i in 1..7
      unless current_location[0] - i > 7 || current_location[0] - i < 0
        down_vertical_moves << [current_location[0] - i, current_location[1]]
      end
    end
    if rook_color == WHITE_ROOK
      down_vertical_moves = get_rook_direction_moves(chess_board, current_location, down_vertical_moves, BLACK_ROOK)
    else
      down_vertical_moves = get_rook_direction_moves(chess_board, current_location, down_vertical_moves, WHITE_ROOK)
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
    if rook_color == WHITE_ROOK
      right_horizontal_moves = get_rook_direction_moves(chess_board, current_location, right_horizontal_moves, BLACK_ROOK)
    else
      right_horizontal_moves = get_rook_direction_moves(chess_board, current_location, right_horizontal_moves, WHITE_ROOK)
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
    if rook_color == WHITE_ROOK
      left_horizontal_moves= get_rook_direction_moves(chess_board, current_location, left_horizontal_moves, BLACK_ROOK)
    else
      left_horizontal_moves= get_rook_direction_moves(chess_board, current_location, left_horizontal_moves, WHITE_ROOK)
    end

    left_horizontal_moves
  end
end