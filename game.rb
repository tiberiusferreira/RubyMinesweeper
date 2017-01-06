require_relative 'board'
class Game
  def initialize
    @board = Board.new(5, 5)
    @board.print_grid
  end

  def run
    @board.print_board
  end
end

game = Game.new
game.run