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
    if settings.length < 3
      puts "invalid options"
      setup
    else
      start_round(settings.shift.to_i, settings.shift.to_i, settings.shift.to_i)
    end
  end
  def start_round(width, height, bombs)
    @grid = Grid.new(width, height, bombs)
    until @grid.won || @grid.lost
      puts @grid
      choose_move
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
  def choose_move
    puts "Please reveal (x,y) or flag (x,y,f) a tile."
    input = gets.chomp.split(",")
    if input.length < 2
      puts "invalid move."
      return nil
    end
    tile = input.slice!(0..1)
    tile = tile.map{|e| e.to_i}
    if input.length == 0
      make_move(tile)
    else
      handle_options(tile, input[0])
    end
  end
  def handle_options(tile, option)
    case option.upcase
    when "F" then @grid.toggle_flag(tile) if @grid.is_valid_move?(tile)
    else
      puts "invalid option."
    end
  end

  def make_move(tile)
    if !@grid.is_valid_move?(tile)
      puts "invalid move."
    elsif @grid.flagged?(tile)
      puts "This tile is flagged. Are you sure you wanna reveal it?? (Y/N)"
      if gets.chomp.upcase == "Y"
        @grid.move(tile)
      end
    else
      @grid.move(tile)
    end
  end

end
Minesweeper.run
