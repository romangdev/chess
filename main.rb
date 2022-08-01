# frozen_string_literal: true

require './lib/board'
require './lib/player_white'
require './lib/player_black'
require './lib/game'
require './lib/square_pieces'
require './lib/pieces/pawn'
require './lib/chess_pieces'
require './lib/chess'

include ChessPieces

WHITE_PIECES = [WHITE_PAWN,
                WHITE_ROOK,
                WHITE_KNIGHT,
                WHITE_BISHOP,
                WHITE_QUEEN,
                WHITE_KING].freeze

BLACK_PIECES = [BLACK_PAWN,
                BLACK_ROOK,
                BLACK_KNIGHT,
                BLACK_BISHOP,
                BLACK_QUEEN,
                BLACK_KING].freeze

board = Board.new
board.generate_board
board.display_board

player_white = PlayerWhite.new
player_black = PlayerBlack.new

game = Game.new
# change 3, 2 back to 0, 4
chess = Chess.new(board.chess_board[0][4], board.chess_board[7][4])

move_count = 0
white_pieces_lost = []
black_pieces_lost = []

loop do
  # Player White Turn

  # TEST FOR STALEMATE
  w_king_loc = chess.find_king_location(board, 'white')

  # CHECK IF ANY WHITE PIECE BESIDES KING HAVE MOVES LEFT
  if chess.w_king.checked == false
    moves_left = false
    (0..7).each do |i|
      (0..7).each do |n|
        next unless board.chess_board[i][n] != '   ' && (WHITE_PIECES.include? board.chess_board[i][n].piece_symbol)

        piece = board.chess_board[i][n]
        check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)

        case piece.piece_symbol
        when WHITE_PAWN, WHITE_KNIGHT
          moves_left = true unless check_moves.empty?
        when WHITE_BISHOP, WHITE_QUEEN, WHITE_ROOK
          check_moves.each do |row|
            moves_left = true unless row.empty?
          end
        end
      end
    end

    unless moves_left == true
      king_moves = chess.w_king.generate_moves([i, n], board.chess_board, piece.piece_symbol)
      b_l_castle = false
      b_r_castle = false

      can_move = false
      king_moves.each do |move|
        while can_move == false
          self_check = false
          saved_end_piece = 'nil'
          hold = chess.update_board_movement(board.chess_board, w_king_loc, move, w_l_castle, w_r_castle, b_l_castle,
                                             b_r_castle)
          hold_start_location = hold[0]
          saved_end_piece = hold[1]
          rook_start = hold[2]
          rook_end = hold[3]

          # CHECK AND HANDLE IF PLAYER PUTS THEIR OWN KING IN CHECK
          (0..7).each do |i|
            (0..7).each do |n|
              unless board.chess_board[i][n] != '   ' && BLACK_PIECES.include?(board.chess_board[i][n].piece_symbol)
                next
              end

              piece = board.chess_board[i][n]
              check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)

              case piece.piece_symbol
              when BLACK_PAWN
                pawn_diagonals = []
                pawn_diagonals <<  [i - 1, n + 1]  unless (i - 1).negative? || n + 1 > 7
                pawn_diagonals <<  [i - 1, n - 1]  unless (i - 1).negative? || (n - 1).negative?

                pawn_diagonals.each do |diagonal|
                  unless board.chess_board[diagonal[0]][diagonal[1]] == '   '
                    if board.chess_board[diagonal[0]][diagonal[1]].piece_symbol == WHITE_KING
                      self_check = true
                      chess.undo_board_movement(board.chess_board, hold_start_location, player_end,
                                                saved_end_piece, rook_start, rook_end)
                    else
                      can_move = true
                      break
                    end
                  end
                end

              when BLACK_KNIGHT, BLACK_KING
                if chess.pkk_error_if_check(WHITE_KING, check_moves, board, hold_start_location, player_end,
                                            saved_end_piece, checking_for_mate, rook_start, rook_end)
                  self_check = true
                else
                  can_move = true
                  break
                end
              when BLACK_ROOK, BLACK_BISHOP, BLACK_QUEEN
                if chess.rbq_error_if_check(check_moves, board, WHITE_KING, hold_start_location, player_end,
                                            saved_end_piece, checking_for_mate, rook_start, rook_end)
                  self_check = true
                else
                  can_move = true
                  break
                end
              end
            end
          end
        end
      end
      return 'STALEMATE' if can_move == true

      puts "\n"
    end
  end

  ### END OF STALEMATE TEST

  # TEST FOR KING IN CHECK, AND FOR CHECK SAVER
  w_king_loc = chess.find_king_location(board, 'white')
  king_checkers = chess.find_piece_checking_king(board, BLACK_PIECES, w_king_loc, chess.w_king)
  king_checker_loc_1 = king_checkers[0]
  king_checker_loc_2 = king_checkers[1]

  hold_answers = chess.check_for_king_saver(board, WHITE_PIECES, king_checker_loc_1)
  checked_king_moves = hold_answers[0]
  king_saver = hold_answers[1]

  unless king_saver == false
    hold_answers = chess.check_for_king_saver(board, WHITE_PIECES, king_checker_loc_2)
    king_saver = hold_answers[1]
  end

  white_king_check = board.chess_board[w_king_loc[0]][w_king_loc[1]]
  counter = 0

  ### END OF TEST OF CHECK AND CHECK SAVER

  # TEST FOR CHECKMATE
  if (white_king_check.checked == true) && (king_saver == false)
    checking_for_mate = true
    # if checked_king_moves.empty?
    #   puts "CHECKMATE"
    #   return
    # else
    w_l_castle = false
    w_r_castle = false
    b_l_castle = false
    b_r_castle = false
    checked_king_moves.each do |king_move|
      saved_end_piece = 'nil'
      hold = chess.update_board_movement(board.chess_board, w_king_loc, king_move, w_l_castle, w_r_castle,
                                         b_l_castle, b_r_castle)
      hold_start_location = hold[0]
      saved_end_piece = hold[1]
      rook_start = hold[2]
      rook_end = hold[3]

      (0..7).each do |i|
        (0..7).each do |n|
          next unless board.chess_board[i][n] != '   ' && BLACK_PIECES.include?(board.chess_board[i][n].piece_symbol)

          piece = board.chess_board[i][n]
          check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)

          case piece.piece_symbol
          when BLACK_PAWN
            pawn_diagonals = []
            pawn_diagonals <<  [i - 1, n + 1]  unless (i - 1).negative? || n + 1 > 7
            pawn_diagonals <<  [i - 1, n - 1]  unless (i - 1).negative? || (n - 1).negative?

            pawn_diagonals.each do |diagonal|
              unless board.chess_board[diagonal[0]][diagonal[1]] != '   ' && (board.chess_board[diagonal[0]][diagonal[1]].piece_symbol == WHITE_KING)
                next
              end

              chess.undo_board_movement(board.chess_board, hold_start_location, king_move, saved_end_piece,
                                        rook_start, rook_end)
              counter += 1
              break
            end

          when BLACK_KNIGHT, BLACK_KING
            if chess.pkk_error_if_check(WHITE_KING, check_moves, board, hold_start_location, king_move,
                                        saved_end_piece, checking_for_mate, rook_start, rook_end)
              counter += 1
              break
            end
          when BLACK_ROOK, BLACK_BISHOP, BLACK_QUEEN
            if chess.rbq_error_if_check(check_moves, board, WHITE_KING, hold_start_location, king_move,
                                        saved_end_piece, checking_for_mate, rook_start, rook_end)
              counter += 1
              break
            end
          end
        end
      end
    end
    # end
    if counter == checked_king_moves.length
      puts 'CHECKMATE'
      return
    end
  end

  checking_for_mate = false
  king_present = chess.disappearing_king_checkmate(board, WHITE_KING)
  return if king_present == false

  #### END OF TEST FOR CHECKMATE

  chess.fix_king_movement(king_present, board, WHITE_KING, w_king_loc)

  self_check = true
  while self_check
    # GRAB PLAYER PIECE CHOICE AND GENERATE AVAILABLE MOVES WITH THAT PIECE
    available_moves = false
    until available_moves
      confirmed = false
      until confirmed
        flag = false
        until flag
          done = false
          until done
            player_choice = game.get_player_location(player_white.player_color)
            done = game.handle_ask_for_draw(player_choice, player_white, player_black, done)
            return if done == 'end'
          end

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
      move_count += 1 unless piece_to_move.is_a? Pawn
      move_count = 0 if piece_to_move.is_a? Pawn
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

    ### END OF PIECE CHOICE/MOVE GENERATION

    confirmed = false
    until confirmed
      flag = false

      # GET AND VERIFY THE LOCATION PLAYER WANTS TO MOVE TO
      until flag
        player_end = game.get_end_location(player_white.player_color)
        player_end_hold = player_end.join('')
        player_end = game.convert_player_location(player_end)
        flag = game.verify_possible_move(possible_moves, player_end)
        puts "You can't move there! Try again..." if flag == false
      end

      save_player_end = board.chess_board[player_end[0]][player_end[1]]

      end_confirm = game.get_end_move_confirm(player_end_hold)
      confirmed = game.handle_confirm_choice(end_confirm)
      chess.repick_move?(confirmed, player_end, board, player_choice, possible_moves)

      ### END OF MOVEMENT VERIFICATION

      # should be w for black player
      b_l_castle = false
      b_r_castle = false

      self_check = false
      saved_end_piece = 'nil'
      hold = chess.update_board_movement(board.chess_board, player_choice, player_end, w_l_castle, w_r_castle,
                                         b_l_castle, b_r_castle)
      hold_start_location = hold[0]
      saved_end_piece = hold[1]
      rook_start = hold[2]
      rook_end = hold[3]

      # CHECK AND HANDLE IF PLAYER PUTS THEIR OWN KING IN CHECK
      (0..7).each do |i|
        (0..7).each do |n|
          next unless board.chess_board[i][n] != '   ' && BLACK_PIECES.include?(board.chess_board[i][n].piece_symbol)

          piece = board.chess_board[i][n]
          check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)

          case piece.piece_symbol
          when BLACK_PAWN
            pawn_diagonals = []
            pawn_diagonals <<  [i - 1, n + 1]  unless (i - 1).negative? || n + 1 > 7
            pawn_diagonals <<  [i - 1, n - 1]  unless (i - 1).negative? || (n - 1).negative?

            pawn_diagonals.each do |diagonal|
              unless board.chess_board[diagonal[0]][diagonal[1]] != '   ' && (board.chess_board[diagonal[0]][diagonal[1]].piece_symbol == WHITE_KING)
                next
              end

              self_check = true
              chess.undo_board_movement(board.chess_board, hold_start_location, player_end, saved_end_piece,
                                        rook_start, rook_end)
              puts 'Your king is in check after that move. Try another move!'
              break
            end

          when BLACK_KNIGHT, BLACK_KING
            if chess.pkk_error_if_check(WHITE_KING, check_moves, board, hold_start_location, player_end,
                                        saved_end_piece, checking_for_mate, rook_start, rook_end)
              self_check = true
              break
            end
          when BLACK_ROOK, BLACK_BISHOP, BLACK_QUEEN
            if chess.rbq_error_if_check(check_moves, board, WHITE_KING, hold_start_location, player_end,
                                        saved_end_piece, checking_for_mate, rook_start, rook_end)
              self_check = true
              break
            end
          end
        end
      end
      puts "\n"
    end
  end

  ### END OF HANDLING A SELF CHECK MOVE

  # CHECK AND HANDLE IF PLAYER PUTS OPPOSITE PLAYER'S KING IN CHECK
  (0..7).each do |i|
    (0..7).each do |n|
      next unless board.chess_board[i][n] != '   ' && WHITE_PIECES.include?(board.chess_board[i][n].piece_symbol)

      piece = board.chess_board[i][n]
      check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)

      case piece.piece_symbol
      when WHITE_PAWN
        pawn_diagonals = []
        pawn_diagonals <<  [i + 1, n + 1]  unless i + 1 > 7 || n + 1 > 7
        pawn_diagonals <<  [i + 1, n - 1]  unless i + 1 > 7 || (n - 1).negative?

        pawn_diagonals.each do |diagonal|
          unless board.chess_board[diagonal[0]][diagonal[1]] != '   ' && (board.chess_board[diagonal[0]][diagonal[1]].piece_symbol == BLACK_KING)
            next
          end

          board.chess_board[diagonal[0]][diagonal[1]].checked = true
          print "CHECKED: #{board.chess_board[diagonal[0]][diagonal[1]].checked}\n"
          break
        end
      when WHITE_KNIGHT

        break if chess.pk_checking_king?(check_moves, board, BLACK_KING)
      when WHITE_ROOK, WHITE_BISHOP, WHITE_QUEEN

        break if chess.rbq_checking_king?(check_moves, board, BLACK_KING)
      end
    end
  end

  ### END OF OPPOSITE PLAYER KING CHECK

  chess.pawn_promotion(board.chess_board, WHITE_PAWN)
  chess.w_king.checked = false
  board.display_board

  unless save_player_end == '   '
    move_count = 0 if BLACK_PIECES.include? save_player_end.piece_symbol
    black_pieces_lost << save_player_end.piece_symbol
  end

  print "White Pieces Lost: #{white_pieces_lost}\n"
  print "Black Pieces Lost: #{black_pieces_lost}\n"

  if move_count == 50
    puts 'Game tied! 50-move rule has been reached!'
    return
  end

  # Player Black Turn

  # TEST FOR KING IN CHECK, AND FOR CHECK SAVER
  b_king_loc = chess.find_king_location(board, 'black')
  king_checker_loc = chess.find_piece_checking_king(board, WHITE_PIECES, b_king_loc, chess.b_king)

  hold_answers = chess.check_for_king_saver(board, BLACK_PIECES, king_checker_loc)
  checked_king_moves = hold_answers[0]
  king_saver = hold_answers[1]

  black_king_check = board.chess_board[b_king_loc[0]][b_king_loc[1]]
  counter = 0

  ### END OF TEST OF CHECK AND CHECK SAVER

  # TEST FOR CHECKMATE
  if (black_king_check.checked == true) && (king_saver == false)
    checking_for_mate = true
    if checked_king_moves.empty?
      puts 'CHECKMATE'
      return
    else
      w_l_castle = false
      w_r_castle = false
      b_l_castle = false
      b_r_castle = false
      checked_king_moves.each do |king_move|
        saved_end_piece = 'nil'
        hold = chess.update_board_movement(board.chess_board, b_king_loc, king_move, w_l_castle, w_r_castle,
                                           b_l_castle, b_r_castle)
        hold_start_location = hold[0]
        saved_end_piece = hold[1]
        rook_start = hold[2]
        rook_end = hold[3]

        (0..7).each do |i|
          (0..7).each do |n|
            next unless board.chess_board[i][n] != '   ' && WHITE_PIECES.include?(board.chess_board[i][n].piece_symbol)

            piece = board.chess_board[i][n]
            check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)

            case piece.piece_symbol
            when WHITE_PAWN
              pawn_diagonals = []
              pawn_diagonals <<  [i + 1, n + 1]  unless i + 1 > 7 || n + 1 > 7
              pawn_diagonals <<  [i + 1, n - 1]  unless i + 1 > 7 || (n - 1).negative?

              pawn_diagonals.each do |diagonal|
                unless board.chess_board[diagonal[0]][diagonal[1]] != '   ' && (board.chess_board[diagonal[0]][diagonal[1]].piece_symbol == BLACK_KING)
                  next
                end

                chess.undo_board_movement(board.chess_board, hold_start_location, king_move, saved_end_piece,
                                          rook_start, rook_end)
                counter += 1
                break
              end

            when WHITE_KNIGHT, WHITE_KING
              if chess.pkk_error_if_check(BLACK_KING, check_moves, board, hold_start_location, king_move,
                                          saved_end_piece, checking_for_mate, rook_start, rook_end)
                counter += 1
                break
              end
            when WHITE_ROOK, WHITE_BISHOP, WHITE_QUEEN
              if chess.rbq_error_if_check(check_moves, board, BLACK_KING, hold_start_location, king_move,
                                          saved_end_piece, checking_for_mate, rook_start, rook_end)
                counter += 1
                break
              end
            end
          end
        end
      end
    end
    if counter == checked_king_moves.length
      puts 'CHECKMATE'
      return
    end
  end

  checking_for_mate = false
  king_present = chess.disappearing_king_checkmate(board, BLACK_KING)
  return if king_present == false

  #### END OF TEST FOR CHECKMATE

  chess.fix_king_movement(king_present, board, BLACK_KING, b_king_loc)

  self_check = true
  while self_check
    # GRAB PLAYER PIECE CHOICE AND GENERATE AVAILABLE MOVES WITH THAT PIECE
    available_moves = false
    until available_moves
      confirmed = false
      until confirmed
        flag = false
        until flag
          player_choice = game.get_player_location(player_black.player_color)
          player_choice = game.convert_player_location(player_choice)
          flag = game.verify_location_piece(player_black.player_pieces, player_choice, board.chess_board)
          puts "Your piece isn't located there, please try again!" if flag == false && chess.b_king.checked != true
        end

        board.display_board(player_choice)
        piece_confirm = game.get_piece_choice_confirm
        confirmed = game.handle_confirm_choice(piece_confirm)

        chess.repick_piece?(confirmed, player_choice, board)
      end

      piece_to_move = board.chess_board[player_choice[0]][player_choice[1]]
      move_count += 1 unless piece_to_move.is_a? Pawn
      move_count = 0 if piece_to_move.is_a? Pawn
      possible_moves = piece_to_move.generate_moves(player_choice, board.chess_board, piece_to_move.piece_symbol)
      possible_moves = chess.handle_qrb_move_arrays(piece_to_move, possible_moves)

      castle_possibilities = chess.black_castle(b_l_castle, b_r_castle, piece_to_move, possible_moves, board)
      unless castle_possibilities.nil?
        b_r_castle = castle_possibilities[0]
        b_l_castle = castle_possibilities[1]
      end

      available_moves = chess.no_piece_moves?(possible_moves, board)
    end

    puts "\n"
    board.display_board(player_choice, possible_moves)

    ### END OF PIECE CHOICE/MOVE GENERATION

    confirmed = false
    until confirmed
      flag = false

      # GET AND VERIFY THE LOCATION PLAYER WANTS TO MOVE TO
      until flag
        player_end = game.get_end_location(player_black.player_color)
        player_end_hold = player_end.join('')
        player_end = game.convert_player_location(player_end)
        flag = game.verify_possible_move(possible_moves, player_end)
        puts "You can't move there! Try again..." if flag == false
      end

      save_player_end = board.chess_board[player_end[0]][player_end[1]]
      puts "Player end #{save_player_end}"

      end_confirm = game.get_end_move_confirm(player_end_hold)
      confirmed = game.handle_confirm_choice(end_confirm)
      chess.repick_move?(confirmed, player_end, board, player_choice, possible_moves)

      ### END OF MOVEMENT VERIFICATION

      w_l_castle = false
      w_r_castle = false

      self_check = false
      saved_end_piece = 'nil'
      hold = chess.update_board_movement(board.chess_board, player_choice, player_end, w_l_castle, w_r_castle,
                                         b_l_castle, b_r_castle)
      hold_start_location = hold[0]
      saved_end_piece = hold[1]
      rook_start = hold[2]
      rook_end = hold[3]

      # CHECK AND HANDLE IF PLAYER PUTS THEIR OWN KING IN CHECK
      (0..7).each do |i|
        (0..7).each do |n|
          next unless board.chess_board[i][n] != '   ' && WHITE_PIECES.include?(board.chess_board[i][n].piece_symbol)

          piece = board.chess_board[i][n]
          check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)

          case piece.piece_symbol
          when WHITE_PAWN
            pawn_diagonals = []
            pawn_diagonals <<  [i + 1, n + 1]  unless i + 1 > 7 || n + 1 > 7
            pawn_diagonals <<  [i + 1, n - 1]  unless i + 1 > 7 || (n - 1).negative?

            pawn_diagonals.each do |diagonal|
              unless board.chess_board[diagonal[0]][diagonal[1]] != '   ' && (board.chess_board[diagonal[0]][diagonal[1]].piece_symbol == BLACK_KING)
                next
              end

              self_check = true
              chess.undo_board_movement(board.chess_board, hold_start_location, player_end, saved_end_piece,
                                        rook_start, rook_end)
              puts 'Your king is in check after that move. Try another move!'
              break
            end

          when WHITE_KNIGHT, WHITE_KING
            if chess.pkk_error_if_check(BLACK_KING, check_moves, board, hold_start_location, player_end,
                                        saved_end_piece, checking_for_mate, rook_start, rook_end)
              self_check = true
              break
            end
          when WHITE_ROOK, WHITE_BISHOP, WHITE_QUEEN
            if chess.rbq_error_if_check(check_moves, board, BLACK_KING, hold_start_location, player_end,
                                        saved_end_piece, checking_for_mate, rook_start, rook_end)
              self_check = true
              break
            end
          end
        end
      end
      puts "\n"
    end
  end

  ### END OF HANDLING A SELF CHECK MOVE

  # CHECK AND HANDLE IF PLAYER PUTS OPPOSITE PLAYER'S KING IN CHECK
  (0..7).each do |i|
    (0..7).each do |n|
      next unless board.chess_board[i][n] != '   ' && BLACK_PIECES.include?(board.chess_board[i][n].piece_symbol)

      piece = board.chess_board[i][n]
      check_moves = piece.generate_moves([i, n], board.chess_board, piece.piece_symbol)

      case piece.piece_symbol
      when BLACK_PAWN
        pawn_diagonals = []
        pawn_diagonals <<  [i - 1, n + 1]  unless (i - 1).negative? || n + 1 > 7
        pawn_diagonals <<  [i - 1, n - 1]  unless (i - 1).negative? || (n - 1).negative?

        pawn_diagonals.each do |diagonal|
          unless board.chess_board[diagonal[0]][diagonal[1]] != '   ' && (board.chess_board[diagonal[0]][diagonal[1]].piece_symbol == WHITE_KING)
            next
          end

          board.chess_board[diagonal[0]][diagonal[1]].checked = true
          print "CHECKED: #{board.chess_board[diagonal[0]][diagonal[1]].checked}\n"
          break
        end
      when BLACK_KNIGHT

        break if chess.pk_checking_king?(check_moves, board, WHITE_KING)
      when BLACK_ROOK, BLACK_BISHOP, BLACK_QUEEN

        break if chess.rbq_checking_king?(check_moves, board, WHITE_KING)
      end
    end
  end

  ### END OF OPPOSITE PLAYER KING CHECK

  chess.pawn_promotion(board.chess_board, BLACK_PAWN)
  chess.b_king.checked = false
  board.display_board

  unless save_player_end == '   '
    move_count = 0 if WHITE_PIECES.include? save_player_end.piece_symbol
    white_pieces_lost << save_player_end.piece_symbol
  end

  print "White Pieces Lost: #{white_pieces_lost}\n"
  print "Black Pieces Lost: #{black_pieces_lost}\n"

  if move_count == 50
    puts 'Game tied! 50-move rule has been reached!'
    return
  end
end
