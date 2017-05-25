class HumanPlayer

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def convert_move(string)
    nums = string.chars.select { |i| '1234567890'.include?(i) }
    nums.map { |j| j.to_i }
  end

  def valid_move?(pos, board)
    return false unless pos.length == 2
    return false unless pos.all? { |i| i <= board.grid.length - 1 }
    return false unless board[pos] == :s || board[pos].nil?
    true
  end

  def get_play(board)
    print 'Attack where? ex) 0, 2: '
    pos = convert_move(gets.chomp)
    until valid_move?(pos, board)
      print 'Please choose an empty space: '
      pos = convert_move(gets.chomp)
    end
    pos
  end

end
