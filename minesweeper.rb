require_relative 'grid'
class Minesweeper
  def initialize
  end
  def start_round
    width = 10
    height = 10
    bombs = 10
    @grid = Grid.new(width, height, bombs)
    until @grid.won || @grid.lost
      puts @grid
      make_move
    end
  end
  def make_move
    puts "Please select a tile. (x, y)"
    tile = nil
    loop do
      tile = gets.chomp.split(",").map{ |e| e.to_i }
      break if @grid.is_valid_move?(tile)
      puts "Invalid move, please try again. (x, y)"
    end
    @grid.move(tile)
  end
end
game = Minesweeper.new
game.start_round
