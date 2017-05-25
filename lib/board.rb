class Board

  attr_reader :grid

  def initialize(size = 5)
    @grid = Array.new(size) { Array.new(size) }
  end

  # def self.default_grid(size = 10)
  #   Array.new(size) { Array.new(size) }
  # end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end

  def count
    count = 0
    @grid.each do |row|
      row.each do |col|
        count += 1 if col == :s
      end
    end
    count
  end

  def empty?(pos = nil)
    unless pos.nil?
      return true if self[pos].nil?
      return false
    end

    self.grid.each do |row|
      return false unless row.all? { |col| col.nil? }
    end
    true
  end

  def full?
    self.grid.each do |row|
      return false if row.any? { |col| col.nil? }
    end
    true
  end

  def place_random_ship
    raise 'Error' if self.full?
    pos = [rand(self.grid.length), rand(self.grid.length)]
    until self.empty?(pos)
      pos = [rand(self.grid.length), rand(self.grid.length)]
    end
    self[pos] = :s
  end

  def won?
    self.grid.each do |row|
      return false if row.any? { |col| col == :s }
    end
    true
  end

  def display
    display = { :m => "M", :h => "H", :s => "~", nil => "~" }
    display_grid = @grid.map do |row|
      row.map { |char| display[char] }
    end
    display_grid.map! { |line| line.join(" | ") }
    display_grid.join("\n#{"----" * (@grid.length - 1)}--\n")
  end

  def attack(pos)
    if self[pos].nil?
      self[pos] = :m
    else
      self[pos] = :h
    end
  end

  def populate_grid(ships = 5)
    count = 0
    until count == ships
      self.place_random_ship
      count += 1
    end
    self
  end

end
