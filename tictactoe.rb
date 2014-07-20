LINES = [
       [0, 1, 2], [3, 4, 5], [6, 7, 8],
       [0, 3, 6], [1, 4, 7], [2, 5, 8],
       [2, 4, 6], [0, 4, 8]
]

def is_winner?(index, board)
  LINES.each do |line|
    return true if (board[line[0]].to_i + board[line[1]].to_i + board[line[2]].to_i).abs == 3
  end
  false
end

def do_move(index, board, turn)
  board[index-1] = turn
end

def is_valid?(index, board)
  (1..9).include?(index) && board[(index-1)] == nil
end

def print_board(board)
  puts " #{display(board[0])} | #{display(board[1])} | #{display(board[2])} "
  puts "---+---+---"
  puts " #{display(board[3])} | #{display(board[4])} | #{display(board[5])} "
  puts "---+---+---"
  puts " #{display(board[6])} | #{display(board[7])} | #{display(board[8])} "
end

def display(move)
  {nil => ' ', -1 => 'O', 1 => 'X'}[move]
end

def get_best_move(board)
  return 5 if board[4].nil?

  return best_move(board, -2) || best_move(board, 2) || rand(0..9)
end

def best_move(board, winning_score)
  LINES.each do |line|
    if board[line[0]].to_i + board[line[1]].to_i + board[line[2]].to_i == winning_score
      return line[0] + 1 if board[line[0]].nil?
      return line[1] + 1 if board[line[1]].nil?
      return line[2] + 1 if board[line[2]].nil?
    end
  end
  return false
end

def is_board_full?(board)
  board.compact.count == 9
end

puts "Welcome to tic tac toe"
board = Array.new(9)
turn = 1

while true
  puts print_board(board)
  puts "Player #{display(turn)}, please enter move (1..9)"

  index = turn == 1 ? gets.to_i : get_best_move(board)

  unless is_valid?(index, board)
    system("clear")
    puts "Incorrect move"
    next
  end

  do_move(index, board, turn)

  if is_winner?(index, board)
    system("clear")
    puts print_board(board)
    puts "Congrats, #{display(turn)}!"
    break
  end

  if is_board_full?(board)
    system("clear")
    puts print_board(board)
    puts "Draw!"
    break
  end

   system("clear")
  turn *= -1
end