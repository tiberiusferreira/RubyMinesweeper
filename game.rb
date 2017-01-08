require_relative 'board'
# require_relative 'tests/board_test'
class Game

  attr_accessor :board_size
  attr_accessor :number_mines

  def initialize(board_sz, nb_mines)
    @board_size = board_sz
    @number_mines = nb_mines
    @board = Board.new(board_size, number_mines)
  end

  # prompts the user with "message" and reads an integer from the console
  def get_int(message)
    while 1
      puts message
      input = gets.chomp
      begin
        input = Integer(input)
        return input
      rescue ArgumentError, TypeError
        puts 'This is not a valid input'
      end
    end
  end

  # main game loop
  def run
    while 1
      @board.print_board
      row = get_int("Please type a row number (0-#{board_size-1})")
      col = get_int("Please type a col number (0-#{board_size-1})")
      case @board.open_pos(row,col)
        when -2
          puts 'This position is already opened'
          sleep(1.5)
        when -1
          puts 'This position is not inside the grid'
          sleep(1.5)
        when 2
          puts "Sorry, you lost, but with some practice you'll get there!"
          @board.print_unlocked_board
          exit(0)
        when 3
          puts 'Awesome, you won! Way to go!'
          @board.print_unlocked_board
          exit(0)
        else
          next
      end
    end
  end


end

game = Game.new(3, 2)
game.run


