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
    position = [rand(board.grid.length), rand(board.grid.length)]
    until valid_move?(position, board)
      position = [rand(board.grid.length), rand(board.grid.length)]
    end
    position
  end

end
