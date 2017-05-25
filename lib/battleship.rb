require_relative 'board'
require_relative 'player'
require_relative 'computer_player'

class BattleshipGame
  attr_reader :board, :player

  def initialize(player, computer_player, size, ships)
    @player_board = Board.new(size).populate_grid(ships)
    @computer_board = Board.new(size).populate_grid(ships)
    @player = player
    @computer_player = computer_player
    @position = -1
  end

  def attack(pos)
    if current_board[pos].nil?
      current_board[pos] = :m
    else
      current_board[pos] = :h
    end
  end

  def current_player
    return @player if @position.even?
    @computer_player
  end

  def current_board
    return @computer_board if @position.even?
    @player_board
  end

  def switch_players
    @position += 1
  end

  def count
    self.board.count
  end

  def game_over?
    self.board.won?
  end

  def play_turn
    switch_players
    input = current_player.get_play(current_board)
    current_board.attack(input)
    puts "#{current_player.name}'s Board to attack"
    puts "#{current_board.display}"
    puts "There are/is #{current_board.count} ship(s) left"
  end

  def play
    until current_board.won?
      play_turn
    end
    puts "#{current_player.name} won!"
  end

  if __FILE__ == $PROGRAM_NAME
    human = HumanPlayer.new('Jard')
    cpu = ComputerPlayer.new('Mr. Battleship')
    print 'What size board? Max 10. Ex: 5 -> 5x5: '
    size = gets.chomp.to_i
    print 'How many ships?: '
    ships = gets.chomp.to_i
    BattleshipGame.new(human, cpu, size, ships).play
  end

end
