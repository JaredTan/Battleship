require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class BattleshipGame

  attr_reader :board

  def initialize(player_one, player_two, size)
    puts "#{player_one.name}: place your ships."
    @player_one_board = Board.new(size).populate_with_ships
    if player_two.class == HumanPlayer
      puts "#{player_two.name}: place your ships."
      @player_two_board = Board.new(size).populate_with_ships
    else
      @player_two_board = Board.new(size).populate_randomly_with_ships
    end
    @player_one = player_one
    @player_two = player_two
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
    return @player_one if @position.even?
    @player_two
  end

  def current_board
    return @player_two_board if @position.even?
    @player_one_board
  end

  def switch_players
    @position += 1
  end

  def game_over?
    self.board.won?
  end

  def play_turn
    switch_players
    prev_ship_count = current_board.ship_count
    puts "#{current_player.name}'s Turn"
    puts "#{current_player.name} has #{current_board.ship_count} ship(s) left to sink."
    display_board_to_attack
    input = current_player.get_play(current_board)
    hit_miss?(input)
    attack(input)
    ship_sunk?(prev_ship_count)
    display_board_to_attack
    puts "#{current_player.name} has #{current_board.ship_count} ship(s) left to sink."
    puts "__________________________________"
  end

  def ship_sunk?(prev_ship_count)
    if current_board.ship_count < prev_ship_count
      puts "You sank a ship!"
      current_board.reveal_ships
    end
  end

  def display_board_to_attack
    puts "#{current_player.name}'s Board to attack"
    puts "#{current_board.display}"
  end

  def hit_miss?(input)
    puts "Hit!" if current_board.hit?(input)
    puts "Miss" unless current_board.hit?(input)
  end

  def play
    until current_board.won?
      play_turn
    end
    puts "#{current_player.name} won!"
  end

  if __FILE__ == $PROGRAM_NAME
    print 'Player one name?: '
    p1 = HumanPlayer.new(gets.chomp)
    print 'Play against a human or a computer? h / c :'
    if gets.chomp == 'c'
      p2 = ComputerPlayer.new('King Battleship')
    else
      print 'Player two name?: '
      p2 = HumanPlayer.new(gets.chomp)
    end
    print 'What size board? Min 5, Max 10. Ex: 7 -> 7x7: '
    size = gets.chomp.to_i
    until size >= 5 && size <= 10
      print 'Please enter a valid board size: '
      size = gets.chomp.to_i
    end
    BattleshipGame.new(p1, p2, size).play
  end
end
