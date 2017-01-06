require_relative 'board'
class Game
  def initialize
    @board = Board.new(3, 2)
  end

def get_int(message)
  while 1
    puts message
    integ = gets.chomp
    begin
      integ = Integer(integ)
      return integ
    rescue ArgumentError, TypeError
     puts 'This is not a valid input'
    end
  end
end

  def run
    while 1
      @board.print_grid
      @board.print_board
      row = get_int('Please type a row number (0-5)')
      col = get_int('Please type a col number (0-5)')
      case @board.open_pos(row,col)
        when -1
          puts 'This position is not inside the grid'
          sleep(1.5)
        when -2
          puts 'Sorry, you lost, but with some practice you are sure to get there!'
          @board.print_board_all
          exit(0)
        when -3
          puts 'Awesome, you won! Way to go!'
          @board.print_board_all
          exit(0)
        else

          next
      end
    end
  end


end

game = Game.new
game.run


