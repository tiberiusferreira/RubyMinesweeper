require_relative '../board'

require 'minitest/autorun'

class Board_test < Minitest::Test
  attr_accessor :board
  attr_accessor :open_not_mine_error
  attr_accessor :open_mine_error
  attr_accessor :open_already_opened_error
  def setup
    @open_not_mine_error = 'Error opening not a mine'
    @open_mine_error = 'Error opening a mine'
    @open_already_opened_error = 'Error opening a position already opened'
    @mines_grid = [
        [0, 0, 0],
        [0, 1, 0],
        [0, 1, 1]
    ]
    @board = Board.new(3, 3, @mines_grid)
  end

  def test_win
    assert_equal(0, board.open_pos(0,0), open_not_mine_error)
    assert_equal(0, board.open_pos(0,1), open_not_mine_error)
    assert_equal(0, board.open_pos(0,2), open_not_mine_error)

    assert_equal(0, board.open_pos(1,0), open_not_mine_error)
    assert_equal(0, board.open_pos(1,2), open_not_mine_error)

    assert_equal(3, board.open_pos(2,0), open_not_mine_error)
  end

  def test_lose
    assert_equal(0, board.open_pos(0,0), open_not_mine_error)
    assert_equal(0, board.open_pos(0,1), open_not_mine_error)
    assert_equal(0, board.open_pos(0,2), open_not_mine_error)

    assert_equal(2, board.open_pos(1,1), open_mine_error)
  end

  def test_already_opened
    assert_equal(0, board.open_pos(0,0), open_not_mine_error)
    assert_equal(0, board.open_pos(0,1), open_not_mine_error)
    assert_equal(0, board.open_pos(0,2), open_not_mine_error)

    assert_equal(0, board.open_pos(1,0), open_not_mine_error)
    assert_equal(0, board.open_pos(1,2), open_not_mine_error)

    assert_equal(-2, board.open_pos(0,0), open_already_opened_error)
    assert_equal(-2, board.open_pos(0,1), open_not_mine_error)
    assert_equal(-2, board.open_pos(0,2), open_not_mine_error)

    assert_equal(-2, board.open_pos(1,0), open_not_mine_error)
    assert_equal(-2, board.open_pos(1,2), open_not_mine_error)
  end

  def test_outside_table
    assert_equal(-1, board.open_pos(4,6), open_not_mine_error)
    assert_equal(-1, board.open_pos(-10,2), open_not_mine_error)
    assert_equal(-1, board.open_pos(0,3), open_not_mine_error)
  end


end


