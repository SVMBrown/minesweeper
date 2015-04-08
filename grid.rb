class Grid
  attr_reader :won
  attr_reader :lost
  def initialize(width, height, bomb_amount)
    @width = width
    @height = height
    @bombs = []
    @revealed = []
    @won = false
    @lost = false
    add_bombs(bomb_amount)
  end

  def add_bombs(n)
    n.times do
      bomb = nil
      loop do
        bomb = [rand(@width), rand(@height)]
        break unless @bombs.any? { |e| e == bomb }
      end
      @bombs.push(bomb)
    end
  end

  def hidden?(tile)
    !@revealed.any?{ |e| e == tile }
  end

  def bomb?(tile)
    @bombs.any?{ |e| e == tile }
  end

  def is_valid_move?(tile)
    x_in_bounds = (tile[0] < @width) && (tile[0] >= 0)
    y_in_bounds = (tile[1] < @height) && (tile[1] >= 0)
    hidden?(tile) && x_in_bounds && y_in_bounds
  end

  def move(tile)
    reveal(tile)
    if get_value_at(tile) == "0"
      (-1..1).each do |y|
        (-1..1).each do |x|
          unless y == 0 && x == 0
            move([tile[0]-x, tile[1]-y]) if is_valid_move?([tile[0]-x, tile[1]-y])
          end
        end
      end
    end
  end

  def reveal(tile)
    @revealed.push(tile)
    @lost = bomb?(tile)
    @won = (@bombs.length + @revealed.length) == @width * @height
  end
  def get_value_at(tile)
    if hidden?(tile)
      "#"
    elsif bomb?(tile)
      "X"
    else
      val = 0
      (-1..1).each do |y|
        (-1..1).each do |x|
          unless y == 0 && x == 0
            val += 1 if bomb?([tile[0]-x, tile[1]-y])
          end
        end
      end
      val.to_s
    end
  end

  def to_s
    out = []
    @height.times do |y|
      row = []
      @width.times do |x|
        row << get_value_at([x, y])
      end
      out << row.join(" ")
    end
    out.join("\n")
  end
end
