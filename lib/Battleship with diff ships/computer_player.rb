class ComputerPlayer

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def valid_move?(pos, board)
    return false unless board[pos] == :s || board[pos].nil?
    true
  end

  def get_play(board)
    pos = [rand(board.grid.length), rand(board.grid.length)]
    until valid_move?(pos, board)
      pos = [rand(board.grid.length), rand(board.grid.length)]
    end
    pos
  end

end
