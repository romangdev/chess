# frozen_string_literal: true

require "./lib/board"
require "./lib/player_white"
require "./lib/player_black"
require "./lib/game"
require "./lib/square_pieces"
require "./lib/pieces/pawn"
require "./lib/chess_pieces" 

class Chess 
  include ChessPieces

  attr_accessor :w_king, :b_king

  def initialize(w_king_location, b_king_location)
    @w_king = w_king_location
    @b_king = b_king_location
  end

  # check for pawn promotion possibilities and execute on relevant pawns if so
  def pawn_promotion(board, pawn_color)
    for i in 0..7 
      unless board[7][i] == "   "
        handle_promotion_by_color(board, pawn_color, i) if board[7][i].piece_symbol == pawn_color
      end
    end
  end

  # prompt player to repick their piece to move
  def repick_piece?(confirmed, player_choice, board)
    if confirmed == false
      player_choice = nil 
      board.display_board
      puts "Piece movement aborted. Pick another piece."
    end
  end

  # if piece chosen by player has no possible moves, output message to pick another piece
  def no_piece_moves?(possible_moves, board)
    if possible_moves.empty?
      board.display_board
      puts "Piece has no available moves! Please pick another piece."
    else 
      return true 
    end

    false
  end

  # prompts player to repick their move if they don't confirm their choice
  def repick_move?(confirmed, player_end, board, player_choice, possible_moves)
    if confirmed == false
      player_end = nil 
      board.display_board(player_choice, possible_moves)
      puts "Move choice aborted. Pick another move."
    end
  end

  # update the array representing the chess board to reflect movement
  def update_board_movement(board, player_choice, player_end, w_l_castle = false, w_r_castle = false, b_l_castle = false, b_r_castle = false)
    rook_start = nil
    rook_end = nil
    hold_start_location = player_choice
    tmp_start = board[player_choice[0]][player_choice[1]]
    board[player_choice[0]][player_choice[1]] = "   "
    move_end = board[player_end[0]][player_end[1]]
    board[player_end[0]][player_end[1]] = tmp_start

    # CASTLE DISPLAY
    # if white castle right is available and player chooses correct castle location
    if w_r_castle && player_end == [0, 6]
      hold_rook = board[0][7]
      board[0][7] = "   "
      board[0][5] = hold_rook
      rook_start = [0, 7]
      rook_end = [0, 5]
    elsif w_l_castle && player_end == [0, 2]
      # if white castle left is available and player chooses correct castle location
      hold_rook = board[0][0]
      board[0][0] = "   "
      board[0][3] = hold_rook
      rook_start = [0, 0]
      rook_end = [0, 3]
    end

    # if black castle right is available and player chooses correct castle location
    if b_r_castle && player_end == [7, 6]
      hold_rook = board[7][7]
      board[7][7] = "   "
      board[7][5] = hold_rook
      rook_start = [7, 7]
      rook_end = [7, 5]
    # if black castle left is available and player chooses correct castle location
    elsif b_l_castle && player_end == [7, 2]
      hold_rook = board[7][0]
      board[7][0] = "   "
      board[7][3] = hold_rook
      rook_start = [7, 0]
      rook_end = [7, 3]
    end
    
    #grab and save end piece and starting location piece, to use in 'undo board movement'
    arr = []
    arr << hold_start_location << move_end << rook_start << rook_end
    arr
  end

  # undo any moves made in the case of player putting self in check
  def undo_board_movement(board, start_location, player_end, end_piece, rook_start, rook_end)
    board[start_location[0]][start_location[1]] = board[player_end[0]][player_end[1]]
    board[player_end[0]][player_end[1]] = end_piece

    unless rook_start.nil? && rook_end.nil?
      board[rook_start[0]][rook_start[1]] = board[rook_end[0]][rook_end[1]]
      board[rook_end[0]][rook_end[1]] = "   "
    end
  end
  
  # promote pawn to queen with it's appropriate color
  def handle_promotion_by_color(board, pawn_color, i)
    if pawn_color == WHITE_PAWN
      w_promoted_queen = Queen.new(WHITE_QUEEN)
      board[7][i] = w_promoted_queen
    else
      b_promoted_queen = Queen.new(BLACK_QUEEN)
      board[7][i] = b_promoted_queen
    end
  end

  # prompt player to redo their move if it puts their king in check of opposing player's pawn, knight, or king
  def pkk_error_if_check(king_color, check_moves, board, hold_start_location, player_end, end_piece, mate, rook_start, rook_end)
    check_moves.each do |move|
      unless board.chess_board[move[0]][move[1]] == "   "
        if board.chess_board[move[0]][move[1]].piece_symbol == king_color
          self_check = true
          self.undo_board_movement(board.chess_board, hold_start_location, player_end, end_piece, rook_start, rook_end)
          puts "Your king is in check after that move. Try another move!" if mate == false
          return true
        end
      end
    end
    false
  end

  # prompt player to redo their move if it puts their king in check of opposing player's rook, bishop, or queen
  def rbq_error_if_check(check_moves, board, king_color, hold_start_location, player_end, end_piece, mate, rook_start, rook_end)
    check_moves.each do |move_dir|
      count = 0
      move_dir.each do |location|
        count += 1 if board.chess_board[location[0]][location[1]] == "   "
        unless board.chess_board[location[0]][location[1]] == "   "
          if board.chess_board[location[0]][location[1]].piece_symbol == king_color &&
            (count + 1) == move_dir.length

            self_check = true
            self.undo_board_movement(board.chess_board, hold_start_location, player_end, end_piece, rook_start, rook_end)
            puts "Your king is in check after that move. Try another move!" if mate == false
            return true
          end
        end
      end
    end
    false
  end

  # if player checks opposite player's king with a rook, bishop, or queen, update other player's king
  # object @checked to true
  def rbq_checking_king?(check_moves, board, king_color)
    check_moves.each do |move_dir|
      count = 0
      move_dir.each do |location|
        count += 1 if board.chess_board[location[0]][location[1]] == "   "
        unless board.chess_board[location[0]][location[1]] == "   "
          if board.chess_board[location[0]][location[1]].piece_symbol == king_color &&
            (count + 1) == move_dir.length

            board.chess_board[location[0]][location[1]].checked = true
            print "CHECKED: #{ board.chess_board[location[0]][location[1]].checked}\n"
          end
        end
      end
    end
  end

  # if player checks opposite player's king with a knight, update other player's king
  # object @checked to true
  def pk_checking_king?(check_moves, board, king_color)
    check_moves.each do |move|
      unless board.chess_board[move[0]][move[1]] == "   "
        if board.chess_board[move[0]][move[1]].piece_symbol == king_color
          board.chess_board[move[0]][move[1]].checked = true 
          print "CHECKED: #{ board.chess_board[move[0]][move[1]].checked}\n"
        end
      end
    end
  end

  # queen, rook, and bishop moves are calculated by individual direction arrays, rather than one 
  # array of all moves together. This method combines all individual locations into one array rather
  # than an array of arrays if the piece is one of the aforementioned pieces
  def handle_qrb_move_arrays(piece_to_move, possible_moves)
    if piece_to_move.is_a?(Queen) || piece_to_move.is_a?(Rook) || piece_to_move.is_a?(Bishop)
      tmp_possible_moves = possible_moves

      possible_moves = []
      
      tmp_possible_moves.each do |move_direction|
        unless move_direction.empty?
          move_direction.each do |location|
            possible_moves << location
          end
        end
      end
    end
    possible_moves
  end

  # Find the square that holds the king with the specified color
  def find_king_location(board, color)
    for i in 0..7 
      for n in 0..7 
        unless board.chess_board[i][n] == "   "
          if color == "white"
            if board.chess_board[i][n].piece_symbol == WHITE_KING
              w_king_loc = []
              w_king_loc << i << n
              return w_king_loc
            end
          else
            if board.chess_board[i][n].piece_symbol == BLACK_KING
              b_king_loc = []
              b_king_loc << i << n
              return b_king_loc
            end
          end
        end
      end
    end
  end

  # find the location of the piece that is putting king in check
  def find_piece_checking_king(board, pieces_color, king_color_loc, king_color)
    king_checker_loc = []
    for i in 0..7 
      for n in 0..7 
        unless board.chess_board[i][n] == "   "
          if pieces_color.include?(board.chess_board[i][n].piece_symbol)
            piece = board.chess_board[i][n]
            check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)
  
            if piece.is_a?(Pawn) || piece.is_a?(King) || piece.is_a?(Knight)
              if check_moves.include? king_color_loc
                king_checker_loc << [i, n]
              end
            elsif piece.is_a?(Queen) || piece.is_a?(Rook) || piece.is_a?(Bishop)
              check_moves.each do |move_direction|
                if move_direction.include? king_color_loc
                  king_checker_loc << [i, n]
                end
              end
            end
          end
        end
      end
    end
    king_checker_loc
  end

  # handle disappearing king indicating a checkmate has occured
  def disappearing_king_checkmate(board, king_color)
    checkmate = false
    king_present = false
    board.chess_board.each do |row|
      row.each do |square|
        unless square == "   "
         king_present = true if square.piece_symbol == king_color
        end
      end
    end
    if king_present == false
      puts "CHECKMATE"
    end
    king_present
  end

  # handles unintentional king movement that sometimes occurs after check for checkmate
  def fix_king_movement(king_present, board, king_color, king_loc)
    if (king_present) == true && board.chess_board[king_loc[0]][king_loc[1]] == "   "
      for i in 0..7 
        for n in 0..7
          unless board.chess_board[i][n] == "   "
            if board.chess_board[i][n].piece_symbol == king_color
              save_piece = board.chess_board[i][n]
              board.chess_board[i][n] = "   "
            end
          end
        end
      end
  
      board.chess_board[king_loc[0]][king_loc[1]] = save_piece
    end
  end

  # perform logic for player white castling
  def white_castle(w_l_castle, w_r_castle, piece_to_move, possible_moves, board)
    if (piece_to_move.is_a? King) && (piece_to_move.first_move_made == false)
      castle_possibilities = []
      piece_to_move.first_move_made = true
      right_w_rook_check = board.chess_board[0][7]
      left_w_rook_check = board.chess_board[0][0]

      if right_w_rook_check.is_a?(Rook) && board.chess_board[0][5] == "   " && board.chess_board[0][6] == "   " &&
        board.chess_board[0][4] == piece_to_move

        possible_moves << [0, 6]
        w_r_castle = true
        castle_possibilities << w_r_castle
        puts "can castle"
      else 
        castle_possibilities << false
      end
      if left_w_rook_check.is_a?(Rook) && board.chess_board[0][3] == "   " && board.chess_board[0][2] == "   " &&
        board.chess_board[0][1] == "   " && board.chess_board[0][4] == piece_to_move

        possible_moves << [0, 2]
        w_l_castle = true
        castle_possibilities << w_l_castle
        puts "can castle"
      else 
        castle_possibilities << false
      end
    end

    castle_possibilities
  end

  # perform logic for player black castling
  def black_castle(b_l_castle, b_r_castle, piece_to_move, possible_moves, board)
    if (piece_to_move.is_a? King) && (piece_to_move.first_move_made == false)
      castle_possibilities = []
      piece_to_move.first_move_made = true
      right_b_rook_check = board.chess_board[7][7]
      left_b_rook_check = board.chess_board[7][0]

      if right_b_rook_check.is_a?(Rook) && board.chess_board[7][5] == "   " && board.chess_board[7][6] == "   " &&
        board.chess_board[7][4] == piece_to_move

        possible_moves << [7, 6]
        b_r_castle = true
        castle_possibilities << b_r_castle
        puts "can castle"
      else 
        castle_possibilities << false
      end

      if left_b_rook_check.is_a?(Rook) && board.chess_board[7][3] == "   " && board.chess_board[7][2] == "   " &&
        board.chess_board[7][1] == "   " && board.chess_board[7][4] == piece_to_move

        possible_moves << [7, 2]
        b_l_castle = true
        castle_possibilities << b_l_castle
        puts "can castle"
      else 
        castle_possibilities << false
      end
    end

    castle_possibilities
  end

  # check if any piece can take a piece that's checking the king
  def check_for_king_saver(board, pieces_color, king_checker_loc)
    king_saver = false
    check = false
    hold_answers = []

    for i in 0..7 
      for n in 0..7 
        unless board.chess_board[i][n] == "   "
          if pieces_color.include?(board.chess_board[i][n].piece_symbol)
            piece = board.chess_board[i][n]
            check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)

            if piece.is_a? King
              checked_king_moves = check_moves 
              hold_answers << checked_king_moves
            end
          end
        end
      end
    end

    for i in 0..7 
      for n in 0..7 
        unless board.chess_board[i][n] == "   "
          if pieces_color.include?(board.chess_board[i][n].piece_symbol)
            piece = board.chess_board[i][n]
            check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)
  
            if piece.is_a?(Pawn) ||  piece.is_a?(Knight)
              if check_moves.include? king_checker_loc
                puts "SAVER: #{i}, #{n}"
                king_saver = true
                check = true
                hold_answers << king_saver
              end
            elsif piece.is_a?(Queen) || piece.is_a?(Rook) || piece.is_a?(Bishop)
              check_moves.each do |move_direction|
                if move_direction.include? king_checker_loc
                  puts "SAVER: #{i}, #{n}"
                  king_saver = true
                  check = true
                  hold_answers << king_saver
                end
              end
            end
          end
        end
      end
    end
    hold_answers << king_saver if check == false
    hold_answers
  end
end