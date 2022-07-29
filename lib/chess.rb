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
  def update_board_movement(board, player_choice, player_end, w_l_castle = false, w_r_castle = false)
    hold_start_location = player_choice
    tmp_start = board[player_choice[0]][player_choice[1]]
    board[player_choice[0]][player_choice[1]] = "   "
    move_end = board[player_end[0]][player_end[1]]
    board[player_end[0]][player_end[1]] = tmp_start

    # CASTLE DISPLAY
    # if castle right is available and player chooses correct castle location
    if w_r_castle && player_end == [0, 6]
      hold_rook = board[0][7]
      board[0][7] = "   "
      board[0][5] = hold_rook
    elsif w_l_castle && player_end == [0, 2]
      puts "correct"
      # if castle left is available and player chooses correct castle location
      hold_rook = board[0][0]
      board[0][0] = "   "
      board[0][3] = hold_rook
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
  def pkk_error_if_check(king_color, check_moves, board, hold_start_location, player_end, end_piece)
    check_moves.each do |move|
      unless board.chess_board[move[0]][move[1]] == "   "
        if board.chess_board[move[0]][move[1]].piece_symbol == king_color
          self_check = true
          self.undo_board_movement(board.chess_board, hold_start_location, player_end, end_piece)
          puts "Your king is in check after that move. Try another move!"
          return true
        end
      end
    end
    false
  end

  # prompt player to redo their move if it puts their king in check of opposing player's rook, bishop, or queen
  def rbq_error_if_check(check_moves, board, king_color, hold_start_location, player_end, end_piece)
    check_moves.each do |move_dir|
      count = 0
      move_dir.each do |location|
        count += 1 if board.chess_board[location[0]][location[1]] == "   "
        unless board.chess_board[location[0]][location[1]] == "   "
          if board.chess_board[location[0]][location[1]].piece_symbol == king_color &&
            (count + 1) == move_dir.length

            self_check = true
            self.undo_board_movement(board.chess_board, hold_start_location, player_end, end_piece)
            puts "Your king is in check after that move. Try another move!"
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
chess = Chess.new(board.chess_board[4][7], board.chess_board[7][4])

while true 

  # player white turn

  # handling checkmate

  # FIND THE SQUARE HOLDING THE WHITE KING
  w_king_loc = []
  for i in 0..7 
    for n in 0..7 
      unless board.chess_board[i][n] == "   "
        if board.chess_board[i][n].piece_symbol == WHITE_KING
          w_king_loc << i << n
        end
      end
    end
  end


  # FIND THE BLACK PIECE CHECKING THE KING
  king_checker_loc = []
  for i in 0..7 
    for n in 0..7 
      unless board.chess_board[i][n] == "   "
        if BLACK_PIECES.include?(board.chess_board[i][n].piece_symbol)
          piece = board.chess_board[i][n]
          check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)

          if piece.is_a?(Pawn) || piece.is_a?(King) || piece.is_a?(Knight)
            if check_moves.include? w_king_loc
              king_checker_loc << i << n
            end
          elsif piece.is_a?(Queen) || piece.is_a?(Rook) || piece.is_a?(Bishop)
            check_moves.each do |move_direction|
              if move_direction.include? w_king_loc
                king_checker_loc << i << n
              end
            end
          end
        end
      end
    end
  end

  # CHECK ALL WHITE PIECES (EXCEPT KING) TO SEE IF ANY CONTAIN THE BLACK PIECE CHECKING THE KING
  checked_king_moves = nil
  king_saver = false
  for i in 0..7 
    for n in 0..7 
      unless board.chess_board[i][n] == "   "
        if WHITE_PIECES.include?(board.chess_board[i][n].piece_symbol)
          piece = board.chess_board[i][n]
          check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)

          checked_king_moves = check_moves if piece.is_a? King

          if piece.is_a?(Pawn) ||  piece.is_a?(Knight)
            if check_moves.include? king_checker_loc
              puts "SAVER: #{i}, #{n}"
              king_saver = true
            end
          elsif piece.is_a?(Queen) || piece.is_a?(Rook) || piece.is_a?(Bishop)
            check_moves.each do |move_direction|
              if move_direction.include? king_checker_loc
                puts "SAVER: #{i}, #{n}"
                king_saver = true
              end
            end
          end
        end
      end
    end
  end

  white_king_check = board.chess_board[w_king_loc[0]][w_king_loc[1]]
  # generate all black moves
  # starting from 1, for each move white can make, if that move puts it in another piece's array moves
  # then add the counter number to possible checkmate array. Only increment when going to next king move. 
  # for numbers 1 up to and including king_moves.length, if they possible checkmate array includes all those
  # numbers, then king can't get out of check (CHECKMATE)
  counter = 0

  # also, if no king saver && king moves array is empty && checked, game over
  if (white_king_check.checked == true) && (king_saver == false)
    if checked_king_moves.empty?
      puts "GAME OVER"
    else 
      w_l_castle = false
      w_r_castle= true 
      checked_king_moves.each do |king_move|

          saved_end_piece = 'nil'
          hold = chess.update_board_movement(board.chess_board, w_king_loc, king_move, w_l_castle, w_r_castle)
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
                          puts "Your king is in check after that move. Try another move!"
                          counter += 1
                          break
                        end
                      end
                    end

                  elsif  piece.piece_symbol == BLACK_KNIGHT || piece.piece_symbol == BLACK_KING
                    if chess.pkk_error_if_check(WHITE_KING, check_moves, board, hold_start_location, king_move, saved_end_piece)
                      counter += 1
                      break
                    end
                  elsif piece.piece_symbol == BLACK_ROOK || piece.piece_symbol == BLACK_BISHOP || piece.piece_symbol == BLACK_QUEEN
                    if chess.rbq_error_if_check(check_moves, board, WHITE_KING, hold_start_location, king_move, saved_end_piece)
                      counter += 1
                      break
                    end
                  else 
                    # chess.undo_board_movement(board.chess_board, hold_start_location, king_move, saved_end_piece)
                  end
                end
              end
            end
          end

      end
    end
    puts "CHECKMATE" if counter == checked_king_moves.length
  end


  # handle disappearing king bug that indicates checkmate each time it happens
  w_king_present = false
  board.chess_board.each do |row|
    row.each do |square|
      unless square == "   "
        w_king_present = true if square.piece_symbol == WHITE_KING
      end
    end
  end
  puts "CHECKMATE" if w_king_present == false


  # handle any accidental king movement
  if (w_king_present) == true && board.chess_board[w_king_loc[0]][w_king_loc[0]] == "   "
    puts "switched"
    for i in 0..7 
      for n in 0..7
        unless board.chess_board[i][n] == "   "
          # puts board.chess_board[i][n]
          if board.chess_board[i][n].piece_symbol == WHITE_KING
            puts "king"
            save_piece = board.chess_board[i][n]
            board.chess_board[i][n] = "   "
          end
        end
      end
    end

    board.chess_board[w_king_loc[0]][w_king_loc[1]] = save_piece
  end

  board.display_board


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

    # CASTLE FUNCTIONING
    w_l_castle = false
    w_r_castle = false
    if (piece_to_move.is_a? King) && (piece_to_move.first_move_made == false)
      piece_to_move.first_move_made = true
      right_w_rook_check = board.chess_board[0][7]
      left_w_rook_check = board.chess_board[0][0]

      if right_w_rook_check.is_a?(Rook) && board.chess_board[0][5] == "   " && board.chess_board[0][6] == "   " &&
        possible_moves << [0, 6] && board.chess_board[0][4] == piece_to_move
        w_r_castle = true
        puts "can castle"
      end
      if left_w_rook_check.is_a?(Rook) && board.chess_board[0][3] == "   " && board.chess_board[0][2] == "   " &&
        board.chess_board[0][1] == "   " && board.chess_board[0][4] == piece_to_move

        possible_moves << [0, 2]
        w_l_castle = true
        puts "can castle"
      end
    end
    ###

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

      self_check = false
      saved_end_piece = 'nil'
      hold = chess.update_board_movement(board.chess_board, player_choice, player_end, w_l_castle, w_r_castle)
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
                break if chess.pkk_error_if_check(WHITE_KING, check_moves, board, hold_start_location, player_end, saved_end_piece)
              elsif piece.piece_symbol == BLACK_ROOK || piece.piece_symbol == BLACK_BISHOP || piece.piece_symbol == BLACK_QUEEN
                break if chess.rbq_error_if_check(check_moves, board, WHITE_KING, hold_start_location, player_end, saved_end_piece)
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