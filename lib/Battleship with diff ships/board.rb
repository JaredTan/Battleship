require_relative 'ship'

class Board

  attr_reader :grid, :ships

  def initialize(size = 5)
    @grid = Array.new(size) { Array.new(size) }
    @ships = ships_list
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end

  def won?
    self.grid.each do |row|
      return false if row.any? { |col| col == :s }
    end
    true
  end

  def display
    display = { :m => 'M', :h => 'H', :s => '~', nil => '~', :S => 'S' }
    display_grid = @grid.map do |row|
      row.map { |char| display[char] }
    end
    display_grid.map! { |line| line.join(' | ') }
    display_grid.join("\n#{"----" * (@grid.length - 1)}--\n")
  end

  def pre_display
    display = { :s => 'S', nil => '~' }
    display_grid = @grid.map do |row|
      row.map { |char| display[char] }
    end
    display_grid.map! { |line| line.join(' | ') }
    display_grid.join("\n#{"----" * (@grid.length - 1)}--\n")
  end

  def ship_count
    count = 0
    @ships.each do |ship|
      count += 1 unless ship.sunk?(self)
    end
    count
  end

  def reveal_ships
    @ships.each { |ship| ship.show_ship(self) }
  end

  def hit?(pos)
    return true if self[pos] == :s
    false
  end

  def lots_of_lines
    50.times { puts "\n" }
  end

  def ships_list
    [
      Ship.new('Aircraft Carrier', 5),
      Ship.new('Battleship', 4),
      Ship.new('Destroyer', 3),
      Ship.new('Submarine', 3),
      Ship.new('Patrol Boat', 2)
    ]
  end

  def populate_with_ships
    @ships.each do |ship|
      puts self.pre_display.to_s
      ship.place_ship(self)
    end
    puts self.pre_display.to_s
    lots_of_lines
    puts "All set.\n\n\n\n"
    self
  end

  def populate_randomly_with_ships
    @ships.each do |ship|
      ship.randomly_place_ships(self)
    end
    puts "Computer board all set.\n\n\n\n"
    self
  end
end
