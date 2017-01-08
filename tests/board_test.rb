require_relative '../board'

require 'minitest/autorun'

class Board_test < Minitest::Test
  attr_accessor :board
  def setup
    @mines_grid = [
        [0, 0, 0],
        [0, 1, 0],
        [0, 1, 1]
    ]
    @board = Board.new(3, 3, @mines_grid)
  end

  def test_win
    assert_equal(0, board.open_pos(0,0), "Error opening not a mine")
    assert_equal(0, board.open_pos(0,1), "Error opening not a mine")
    assert_equal(0, board.open_pos(0,2), "Error opening not a mine")

    assert_equal(0, board.open_pos(1,0), "Error opening not a mine")
    assert_equal(0, board.open_pos(1,2), "Error opening not a mine")

    assert_equal(3, board.open_pos(2,0), "Error opening not a mine")
  end

  def test_lose
    assert_equal(0, board.open_pos(0,0), "Error opening not a mine")
    assert_equal(0, board.open_pos(0,1), "Error opening not a mine")
    assert_equal(0, board.open_pos(0,2), "Error opening not a mine")

    assert_equal(2, board.open_pos(1,1), "Error opening a mine")
  end

  def test_already_opened
    assert_equal(0, board.open_pos(0,0), "Error opening not a mine")
    assert_equal(0, board.open_pos(0,1), "Error opening not a mine")
    assert_equal(0, board.open_pos(0,2), "Error opening not a mine")

    assert_equal(0, board.open_pos(1,0), "Error opening not a mine")
    assert_equal(0, board.open_pos(1,2), "Error opening not a mine")

    assert_equal(-2, board.open_pos(0,0), "Error opening not a mine")
    assert_equal(-2, board.open_pos(0,1), "Error opening not a mine")
    assert_equal(-2, board.open_pos(0,2), "Error opening not a mine")

    assert_equal(-2, board.open_pos(1,0), "Error opening not a mine")
    assert_equal(-2, board.open_pos(1,2), "Error opening not a mine")
  end

  def test_outside_table
    assert_equal(-1, board.open_pos(4,6), "Error opening not a mine")
    assert_equal(-1, board.open_pos(-10,2), "Error opening not a mine")
    assert_equal(-1, board.open_pos(0,3), "Error opening not a mine")
  end


end


