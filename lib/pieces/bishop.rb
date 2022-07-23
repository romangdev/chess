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
    up_left_moves = handle_up_left_moves(up_left_moves, current_location, bishop_color, chess_board)
    down_right_moves = handle_down_right_moves(down_right_moves, current_location, bishop_color, chess_board)
    down_left_moves = handle_down_left_moves(down_left_moves, current_location, bishop_color, chess_board)

    # print "UP-RIGHT: #{up_right_moves}\n"
    # print "UP-LEFT: #{up_left_moves}\n"
    # print "DOWN-RIGHT: #{down_right_moves}\n"
    # print "DOWN_LEFT: #{down_left_moves}\n"

    add_moves_to_main_array(up_right_moves, down_right_moves, up_left_moves, down_left_moves, moves)

    moves
  end

  private 

  # get possible moves a bishop can make going a given direction (cut off non-possible moves)
  def get_bishop_direction_moves(chess_board, location, move_direction, color)
    count = 0
    if color == " \u265d ".colorize(:black)
      move_direction.each do |location| 
        if chess_board[location[0]][location[1]] == "   "
          count += 1
          next
        elsif chess_board[location[0]][location[1]].piece_symbol == " \u265f ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265c ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265e ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265d ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265b ".colorize(:black) ||
          chess_board[location[0]][location[1]].piece_symbol == " \u265a ".colorize(:black)

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
        elsif chess_board[location[0]][location[1]].piece_symbol == " \u2659 " ||
          chess_board[location[0]][location[1]].piece_symbol == " \u2656 " ||
          chess_board[location[0]][location[1]].piece_symbol == " \u2658 " ||
          chess_board[location[0]][location[1]].piece_symbol == " \u2657 " ||
          chess_board[location[0]][location[1]].piece_symbol == " \u2655 " ||
          chess_board[location[0]][location[1]].piece_symbol == " \u2654 "

          move_direction = move_direction.slice(0, count + 1)
        else
          move_direction = move_direction.slice(0, count)
        end
      end
    end
    
    move_direction
  end

  # handle grabbing all possible up and rightwards moves depending on bishop color
  def handle_up_right_moves(up_right_moves, current_location, bishop_color, chess_board)
    for i in 1..7
      unless current_location[0] + i > 7 || current_location[1] + i > 7
        up_right_moves << [current_location[0] + i, current_location[1] + i]
      end
    end
    if bishop_color == " \u2657 "
      up_right_moves = get_bishop_direction_moves(chess_board, current_location, up_right_moves, " \u265d ".colorize(:black))
    else
      up_right_moves = get_bishop_direction_moves(chess_board, current_location, up_right_moves, " \u2657 ")
    end

    up_right_moves
  end

  # handle grabbing all possible down and rightwards moves depending on bishop color
  def handle_down_right_moves(down_right_moves, current_location, bishop_color, chess_board)
    for i in 1..7
      unless current_location[0] - i < 0 || current_location[1] + i > 7      
        down_right_moves << [current_location[0] - i, current_location[1] + i]
      end
    end
    if bishop_color == " \u2657 "
      down_right_moves = get_bishop_direction_moves(chess_board, current_location, down_right_moves, " \u265d ".colorize(:black))
    else
      down_right_moves = get_bishop_direction_moves(chess_board, current_location, down_right_moves, " \u2657 ")
    end

    down_right_moves
  end

  # handle grabbing all possible down and leftwards moves depending on bishop color
  def handle_down_left_moves(down_left_moves, current_location, bishop_color, chess_board)
    for i in 1..7
      unless current_location[0] - i < 0 || current_location[1] - i < 0       
        down_left_moves << [current_location[0] - i, current_location[1] - i]
      end
    end
    if bishop_color == " \u2657 "
      down_left_moves = get_bishop_direction_moves(chess_board, current_location, down_left_moves, " \u265d ".colorize(:black))
    else
      down_left_moves = get_bishop_direction_moves(chess_board, current_location, down_left_moves, " \u2657 ")
    end

    down_left_moves
  end

  # handle grabbing all possible up and leftwards moves depending on bishop color
  def handle_up_left_moves(up_left_moves, current_location, bishop_color, chess_board)
    for i in 1..7
      unless current_location[0] + i > 7 || current_location[1] - i < 0    
        up_left_moves << [current_location[0] + i, current_location[1] - i]
      end
    end
    if bishop_color == " \u2657 "
      up_left_moves = get_bishop_direction_moves(chess_board, current_location, up_left_moves, " \u265d ".colorize(:black))
    else
      up_left_moves = get_bishop_direction_moves(chess_board, current_location, up_left_moves, " \u2657 ")
    end

    up_left_moves
  end

    # add all moves from each direction into main moves array
    def add_moves_to_main_array(up_right, down_right, down_left, up_left, moves)
      up_right.each do |move|
        moves << move 
      end
  
      down_right.each do |move|
        moves << move 
      end
  
      down_left.each do |move|
        moves << move 
      end
  
      up_left.each do |move|
        moves << move 
      end
    end
end