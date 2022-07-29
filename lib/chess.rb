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
    elsif w_l_castle && player_end == [0, 2]
      # if white castle left is available and player chooses correct castle location
      hold_rook = board[0][0]
      board[0][0] = "   "
      board[0][3] = hold_rook
    end

    # if black castle right is available and player chooses correct castle location
    if b_r_castle && player_end == [7, 6]
      hold_rook = board[7][7]
      board[7][7] = "   "
      board[7][5] = hold_rook
    # if black castle left is available and player chooses correct castle location
    elsif b_l_castle && player_end == [7, 2]
      hold_rook = board[7][0]
      board[7][0] = "   "
      board[7][3] = hold_rook
    end
    
    #grab and save end piece and starting location piece, to use in 'undo board movement'
    arr = []
    arr << hold_start_location << move_end
    arr
  end

  # undo any moves made in the case of player putting self in check
  def undo_board_movement(board, start_location, player_end, end_piece)
    board[start_location[0]][start_location[1]] = board[player_end[0]][player_end[1]]
    board[player_end[0]][player_end[1]] = end_piece
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
  def pkk_error_if_check(king_color, check_moves, board, hold_start_location, player_end, end_piece, mate)
    check_moves.each do |move|
      unless board.chess_board[move[0]][move[1]] == "   "
        if board.chess_board[move[0]][move[1]].piece_symbol == king_color
          self_check = true
          self.undo_board_movement(board.chess_board, hold_start_location, player_end, end_piece)
          puts "Your king is in check after that move. Try another move!" if mate == false
          return true
        end
      end
    end
    false
  end

  # prompt player to redo their move if it puts their king in check of opposing player's rook, bishop, or queen
  def rbq_error_if_check(check_moves, board, king_color, hold_start_location, player_end, end_piece, mate)
    check_moves.each do |move_dir|
      count = 0
      move_dir.each do |location|
        count += 1 if board.chess_board[location[0]][location[1]] == "   "
        unless board.chess_board[location[0]][location[1]] == "   "
          if board.chess_board[location[0]][location[1]].piece_symbol == king_color &&
            (count + 1) == move_dir.length

            self_check = true
            self.undo_board_movement(board.chess_board, hold_start_location, player_end, end_piece)
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
          if board.chess_board[location[0]][location[1]].piece_symbol == BLACK_KING &&
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
  def find_piece_checking_king(board, pieces_color, king_color_loc)
    king_checker_loc = []
    for i in 0..7 
      for n in 0..7 
        unless board.chess_board[i][n] == "   "
          if pieces_color.include?(board.chess_board[i][n].piece_symbol)
            piece = board.chess_board[i][n]
            check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)
  
            if piece.is_a?(Pawn) || piece.is_a?(King) || piece.is_a?(Knight)
              if check_moves.include? king_color_loc
                king_checker_loc << i << n
                return king_checker_loc
              end
            elsif piece.is_a?(Queen) || piece.is_a?(Rook) || piece.is_a?(Bishop)
              check_moves.each do |move_direction|
                if move_direction.include? king_color_loc
                  king_checker_loc << i << n
                  return king_checker_loc
                end
              end
            end
          end
        end
      end
    end
  end

  # def check_for_king_saver(board, pieces_color, checked_king_moves, king_checker_loc, king_saver)
  #   for i in 0..7 
  #     for n in 0..7 
  #       unless board.chess_board[i][n] == "   "
  #         if pieces_color.include?(board.chess_board[i][n].piece_symbol)
  #           piece = board.chess_board[i][n]
  #           check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)
  
  #           checked_king_moves = check_moves if piece.is_a? King
  
  #           if piece.is_a?(Pawn) ||  piece.is_a?(Knight)
  #             if check_moves.include? king_checker_loc
  #               puts "SAVER: #{i}, #{n}"
  #               king_saver = true
  #               return king_saver
  #             end
  #           elsif piece.is_a?(Queen) || piece.is_a?(Rook) || piece.is_a?(Bishop)
  #             check_moves.each do |move_direction|
  #               if move_direction.include? king_checker_loc
  #                 puts "SAVER: #{i}, #{n}"
  #                 king_saver = true
  #                 return king_saver
  #               end
  #             end
  #           end
  #         end
  #       end
  #     end
  #   end
  # end

  # handle disappearing king indicating a checkmate has occured
  def disappearing_king_checkmate(board, king_color)
    king_present = false
    board.chess_board.each do |row|
      row.each do |square|
        unless square == "   "
         king_present = true if square.piece_symbol == king_color
        end
      end
    end
    puts "CHECKMATE" if king_present == false
    king_present
  end

  # handles unintentional king movement that sometimes occurs after check for checkmate
  def fix_king_movement(king_present, board, king_color, king_loc)
    if (king_present) == true && board.chess_board[king_loc[0]][king_loc[0]] == "   "
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

board = Board.new
board.generate_board
board.display_board

player_white = PlayerWhite.new
player_black = PlayerBlack.new

game = Game.new
# change 3, 2 back to 0, 4
chess = Chess.new(board.chess_board[0][4], board.chess_board[7][4])

while true 

  # player white turn

  # handling checkmate
  w_king_loc = chess.find_king_location(board, "white")
  king_checker_loc = chess.find_piece_checking_king(board, BLACK_PIECES, w_king_loc)

  hold_answers = chess.check_for_king_saver(board, WHITE_PIECES, king_checker_loc)
  checked_king_moves = hold_answers[0]
  king_saver = hold_answers[1]

  white_king_check = board.chess_board[w_king_loc[0]][w_king_loc[1]]
  counter = 0

  if (white_king_check.checked == true) && (king_saver == false)
    checking_for_mate = true
    if checked_king_moves.empty?
      puts "GAME OVER"
    else 
      w_l_castle = false
      w_r_castle= false 
      b_l_castle = false
      b_r_castle = false
      checked_king_moves.each do |king_move|

          saved_end_piece = 'nil'
          hold = chess.update_board_movement(board.chess_board, w_king_loc, king_move, w_l_castle, w_r_castle, b_l_castle, b_r_castle)
          hold_start_location = hold[0]
          saved_end_piece = hold[1]
    
          for i in 0..7 
            for n in 0..7 
              unless board.chess_board[i][n] == "   "
                if BLACK_PIECES.include?(board.chess_board[i][n].piece_symbol)
                  piece = board.chess_board[i][n]
                  check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)

                  if piece.piece_symbol == BLACK_PAWN
                    pawn_diagonals = []
                    pawn_diagonals <<  [i - 1, n + 1]  unless ((i - 1).negative? || n + 1 > 7)
                    pawn_diagonals <<  [i - 1, n - 1]  unless ((i - 1).negative? || (n - 1).negative?)
        
                    pawn_diagonals.each do |diagonal|
                      unless board.chess_board[diagonal[0]][diagonal[1]] == "   "
                        if board.chess_board[diagonal[0]][diagonal[1]].piece_symbol == WHITE_KING
                          # self_check = true
                          chess.undo_board_movement(board.chess_board, hold_start_location, king_move, saved_end_piece)
                          counter += 1
                          break
                        end
                      end
                    end

                  elsif  piece.piece_symbol == BLACK_KNIGHT || piece.piece_symbol == BLACK_KING
                    if chess.pkk_error_if_check(WHITE_KING, check_moves, board, hold_start_location, king_move, saved_end_piece, checking_for_mate)
                      counter += 1
                      break
                    end
                  elsif piece.piece_symbol == BLACK_ROOK || piece.piece_symbol == BLACK_BISHOP || piece.piece_symbol == BLACK_QUEEN
                    if chess.rbq_error_if_check(check_moves, board, WHITE_KING, hold_start_location, king_move, saved_end_piece, checking_for_mate)
                      counter += 1
                      break
                    end
                  end
                end
              end
            end
          end

      end
    end
    puts "CHECKMATE" if counter == checked_king_moves.length
  end

  checking_for_mate = false
  king_present = chess.disappearing_king_checkmate(board, WHITE_KING)

  chess.fix_king_movement(king_present, board, WHITE_KING, w_king_loc)



  puts counter
  print checked_king_moves
  puts "\n"

  available_moves = false
  until available_moves
    confirmed = false
    until confirmed
      flag = false 
      until flag
        player_choice = game.get_player_location(player_white.player_color)
        player_choice = game.convert_player_location(player_choice)
        flag = game.verify_location_piece(player_white.player_pieces, player_choice, board.chess_board)
        puts "Your piece isn't located there, please try again!" if flag == false && chess.w_king.checked != true
      end

      board.display_board(player_choice)
      piece_confirm = game.get_piece_choice_confirm
      confirmed = game.handle_confirm_choice(piece_confirm)

      chess.repick_piece?(confirmed, player_choice, board)
    end

    piece_to_move = board.chess_board[player_choice[0]][player_choice[1]]
    possible_moves = piece_to_move.generate_moves(player_choice, board.chess_board, piece_to_move.piece_symbol)
    possible_moves = chess.handle_qrb_move_arrays(piece_to_move, possible_moves)

    castle_possibilities = chess.white_castle(w_l_castle, w_r_castle, piece_to_move, possible_moves, board)
    unless castle_possibilities.nil?
      w_r_castle = castle_possibilities[0]
      w_l_castle = castle_possibilities[1]
    end

    available_moves = chess.no_piece_moves?(possible_moves, board)
  end

  puts "\n"
  board.display_board(player_choice, possible_moves)

  self_check = true
  while self_check
    confirmed = false
    until confirmed
      flag = false 
      # get and verify the location player wants to move to
      until flag
        player_end = game.get_end_location(player_white.player_color)
        player_end_hold = player_end.join("")
        player_end = game.convert_player_location(player_end)
        flag = game.verify_possible_move(possible_moves, player_end)
        puts "You can't move there! Try again..." if flag == false
      end

      end_confirm = game.get_end_move_confirm(player_end_hold)
      confirmed = game.handle_confirm_choice(end_confirm)
      chess.repick_move?(confirmed, player_end, board, player_choice, possible_moves)

      #should be w for black player
      b_l_castle = false
      b_r_castle = false

      self_check = false
      saved_end_piece = 'nil'
      hold = chess.update_board_movement(board.chess_board, player_choice, player_end, w_l_castle, w_r_castle, b_l_castle, b_r_castle)
      hold_start_location = hold[0]
      saved_end_piece = hold[1]

      # Check and handle if player move puts their own king in check
      for i in 0..7 
        for n in 0..7 
          unless board.chess_board[i][n] == "   "
            if BLACK_PIECES.include?(board.chess_board[i][n].piece_symbol)
              piece = board.chess_board[i][n]
              check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)

              if piece.piece_symbol == BLACK_PAWN
                pawn_diagonals = []
                pawn_diagonals <<  [i - 1, n + 1]  unless ((i - 1).negative? || n + 1 > 7)
                pawn_diagonals <<  [i - 1, n - 1]  unless ((i - 1).negative? || (n - 1).negative?)
    
                pawn_diagonals.each do |diagonal|
                  unless board.chess_board[diagonal[0]][diagonal[1]] == "   "
                    if board.chess_board[diagonal[0]][diagonal[1]].piece_symbol == WHITE_KING
                      self_check = true
                      chess.undo_board_movement(board.chess_board, hold_start_location, player_end, saved_end_piece)
                      puts "Your king is in check after that move. Try another move!"
                      break
                    end
                  end
                end

              elsif  piece.piece_symbol == BLACK_KNIGHT || piece.piece_symbol == BLACK_KING
                break if chess.pkk_error_if_check(WHITE_KING, check_moves, board, hold_start_location, player_end, saved_end_piece, checking_for_mate)
              elsif piece.piece_symbol == BLACK_ROOK || piece.piece_symbol == BLACK_BISHOP || piece.piece_symbol == BLACK_QUEEN
                break if chess.rbq_error_if_check(check_moves, board, WHITE_KING, hold_start_location, player_end, saved_end_piece, checking_for_mate)
              end
            end
          end
        end
      end
      puts "\n"
    end
  end

  # Check and handle if player move puts opposite player's king in check
  for i in 0..7 
    for n in 0..7
      unless board.chess_board[i][n] == "   "
        if WHITE_PIECES.include?(board.chess_board[i][n].piece_symbol)
          piece = board.chess_board[i][n]
          check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)

          if piece.piece_symbol == WHITE_PAWN
            pawn_diagonals = []
            pawn_diagonals <<  [i + 1, n + 1]  unless (i + 1 > 7 || n + 1 > 7)
            pawn_diagonals <<  [i + 1, n - 1]  unless (i + 1 > 7 || (n - 1).negative?)

            pawn_diagonals.each do |diagonal|
              unless board.chess_board[diagonal[0]][diagonal[1]] == "   "
                if board.chess_board[diagonal[0]][diagonal[1]].piece_symbol == BLACK_KING
                  board.chess_board[diagonal[0]][diagonal[1]].checked = true
                  print "CHECKED: #{ board.chess_board[diagonal[0]][diagonal[1]].checked}\n"
                  break
                end
              end
            end
          elsif piece.piece_symbol == WHITE_KNIGHT

            break if chess.pk_checking_king?(check_moves, board, BLACK_KING)
          elsif piece.piece_symbol == WHITE_ROOK || piece.piece_symbol == WHITE_BISHOP ||
            piece.piece_symbol == WHITE_QUEEN

            break if chess.rbq_checking_king?(check_moves, board, BLACK_KING)
          end
        end
      end
    end
  end

  chess.pawn_promotion(board.chess_board, WHITE_PAWN)
  # chess.w_king.checked = false
  board.display_board

  # BLACK TURN CODE COMMENTED OUT TEMPORARILY SO DUPLICATION OF CODE NOT NEEDED TO TEST

end