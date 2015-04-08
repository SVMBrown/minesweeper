require_relative 'grid'
class Minesweeper
  def initialize
  end
  def self.run
    game = Minesweeper.new
    puts "Welcome to Minesweeper!"
    game.setup
  end
  def setup
    puts "Please enter the map settings you wish to play with. (width, height, # of bombs)"
    settings = gets.chomp.split(',')
    start_round(settings.shift.to_i, settings.shift.to_i, settings.shift.to_i)
  end
  def start_round(width, height, bombs)
    @grid = Grid.new(width, height, bombs)
    until @grid.won || @grid.lost
      puts @grid
      make_move
    end
    puts @grid
    completion_alert = []
    if @grid.won
      completion_alert << "Phew... You WON!"
    else
      completion_alert << "BBBOOOOOOOOOM! You lost..."
    end
    completion_alert << "The settings were (w: #{width}, h: #{height}, # of bombs: #{bombs}). Try again? (Y/N)"
    puts completion_alert.join(" ")
    setup if gets.chomp.upcase == "Y"
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
Minesweeper.run
