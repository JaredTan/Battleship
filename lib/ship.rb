class Ship

  attr_accessor :ship_name, :ship_length, :positions_arr

  def initialize(ship_name, ship_length = 3)
    @ship_name = ship_name
    @ship_length = ship_length
    @positions_arr = []
  end

  def place_ship(board)
    start = get_start
    direction = get_direction
    until valid_position?(board, start, direction, @ship_length)
      puts 'Please enter a valid entry: '
      start = get_start
      direction = get_direction
    end
    set(board, start, direction, @ship_length)
    self.obtain_positions(start, direction, @ship_length)
  end

  def randomly_place_ships(board)
    start = [rand(board.grid.length), rand(board.grid.length)]
    directions = ['u', 'l', 'd', 'r']
    direction = directions[rand(4)]
    until valid_position?(board, start, direction, @ship_length)
      start = [rand(board.grid.length), rand(board.grid.length)]
      direction = directions[rand(4)]
    end
    set(board, start, direction, @ship_length)
    self.obtain_positions(start, direction, @ship_length)
  end

  def get_start
    print "#{@ship_name} start position? #{@ship_length}x1: "
    convert_move(gets.chomp)
  end

  def get_direction
    print 'Up, Down, Left, or Right? u / d / l / r : '
    gets.chomp
  end

  def convert_move(string)
    nums = string.chars.select { |i| '1234567890'.include?(i) }
    nums.map { |i| i.to_i }
  end

  def valid_position?(board, pos, direction, ship_length)
    return false unless direction.length == 1 && 'udlr'.include?(direction)
    return false unless pos.length == 2 && pos.all? { |i| i >= 0 && i <= board.grid.length }
    return check_up(board, pos, ship_length) if direction == 'u'
    return check_down(board, pos, ship_length) if direction == 'd'
    return check_left(board, pos, ship_length) if direction == 'l'
    return check_right(board, pos, ship_length) if direction == 'r'
    false
  end

  def check_up(board, pos, ship_length)
    return false unless pos[0] >= ship_length - 1
    return false unless board.grid.transpose[pos[1]][pos[0] - ship_length + 1, ship_length].all? { |i| i.nil? }
    true
  end

  def check_down(board, pos, ship_length)
    return false unless board.grid.length - pos[0] >= ship_length
    return false unless board.grid.transpose[pos[1]][pos[0], ship_length].all? { |i| i.nil? }
    true
  end

  def check_left(board, pos, ship_length)
    return false unless pos[1] >= ship_length - 1
    return false unless board.grid[pos[0]][pos[1] - ship_length + 1, ship_length].all? { |i| i.nil? }
    true
  end

  def check_right(board, pos, ship_length)
    return false unless board.grid.length - pos[1] >= ship_length
    return false unless board.grid[pos[0]][pos[1], ship_length].all? { |i| i.nil? }
    true
  end

  def obtain_positions(pos, direction, ship_length)
    positions_arr = []
    if direction == 'u'
      (0..ship_length - 1).each do |num|
        positions_arr << [(pos[0] - num), pos[1]]
      end
    elsif direction == 'd'
      (0..ship_length - 1).each do |num|
        positions_arr << [(pos[0] + num), pos[1]]
      end
    elsif direction == 'l'
      (0..ship_length - 1).each do |num|
        positions_arr << [pos[0], (pos[1] - num)]
      end
    elsif direction == 'r'
      (0..ship_length - 1).each do |num|
        positions_arr << [pos[0], (pos[1] + num)]
      end
    end
    @positions_arr = positions_arr
  end

  def show_ship(board)
    if self.sunk?(board)
      self.positions_arr.each { |pos| board[pos] = :S }
    end
  end

  def ship_health(board)
    count = 0
    self.positions_arr.each do |pos|
      count += 1 if board[pos] == :s
    end
    count
  end

  def sunk?(board)
    return false if self.ship_health(board) > 0
    true
  end


  def set(board, pos, direction, ship_length)
    if direction == 'u'
      (0..ship_length - 1).each do |num|
        board.grid[pos[0] - num][pos[1]] = :s
      end
    elsif direction == 'd'
      (0..ship_length - 1).each do |num|
        board.grid[pos[0] + num][pos[1]] = :s
      end
    elsif direction == 'l'
      (0..ship_length - 1).each do |num|
        board.grid[pos[0]][pos[1] - num] = :s
      end
    elsif direction == 'r'
      (0..ship_length - 1).each do |num|
        board.grid[pos[0]][pos[1] + num] = :s
      end
    end
  end

end
