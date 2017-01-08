

class Board

  attr_accessor :mines_grid
  attr_accessor :board
  attr_accessor :board_mask
  attr_accessor :opened
  attr_accessor :quantity_mines


  # grid_size = size of grid (NxN)
  # number_mines = number of mines
  # input_mines_grid = binary 2D array representing mines (1 = mine, 0 = not mine)
  # Either give number_mines and grid_size or give an input_mines_grid 2D array
  public
  def initialize(number_mines, grid_size, input_mines_grid = nil)
    if input_mines_grid.nil?
      # create a linear array with zeros representing all the places that do not contain mines
      zeros = Array.new(number_mines*number_mines-grid_size, 0)
      # create a linear array representing the mines (ones)
      ones = Array.new(grid_size,1)
      # merge the two into another linear array
      zeros.concat(ones).shuffle!
      # split the array into smaller ones of same size representing the grid lines
      @mines_grid = zeros.each_slice(number_mines).to_a
    else
      @mines_grid = input_mines_grid
    end
    @quantity_mines = grid_size
    @opened = 0
    # fill each board position with the number of mines next to it or M if the position
    # has a mine
    update_board
    # initialize the board mask with zeros (which means position not open)
    @board_mask = Array.new(mines_grid.size){Array.new(mines_grid.size){0}}
  end


  # Opens a position on the board by changing the board mask, so next time the board
  # is printed its going to show the number of mines close to that position
  # Returns:
  # -2 if position already opened
  # -1 if not inside grid (invalid position)
  # 0 if not a mine
  # 2 if player lost (opened a mine)
  # 3 if player won (opened all non-mines)
  public
  def open_pos(row, col)
    # if inside grid and not open mark as opened
    if inside_grid?(row, col) && !is_open(row,col)
      board_mask[row][col] = 1
      @opened += 1
      # if the opened position does not have mines close to open, open neighbors too
      if board[row][col] == 0
        nearby_elements(row, col).each{ |nearby_row, nearby_col|
          open_pos(nearby_row, nearby_col)
        }
        # if opened a mine, player lost the game
      elsif mines_grid[row][col] == 1
        return 2 # lost
      # if opened all positions expect the mines, player won
      elsif opened == (board.size)*(board.size) - quantity_mines
        return 3 # won
      end
      # if it is inside grid, not opened and the game is not finished
      # just return 0
      0

      # if not inside grid return -1
    elsif !inside_grid?(row, col)
      -1
      # if inside grid but already opened return -2
    else
      -2

    end
  end


  # returns true if the position is already opened, false otherwise
  public
  def is_open(row, col)
    board_mask[row][col] == 1
  end

  # updates board with each position having the number of mines near it
  # or M if it has a mine
  public
  def update_board
    @board = Array.new(mines_grid.size){Array.new(mines_grid.size)}
    (0..board.size-1).each { |row|
      (0..board.size-1).each{ |col|
        # if there is a mine at the position, but B
        if mines_grid[row][col] == 1
          board[row][col] = 'M'
        else
          board[row][col] = number_mines(row,col)
        end
      }
    }
  end

  public
  def print_board
    puts
    (0..(board.size-1)).each { |row|
      (0..(board.size-1)).each { |position|
        print board_mask[row][position] == 1 ? board[row][position].to_s + ' ' : '? '
      }
      puts
    }
  end

  public
  def print_unlocked_board
    print_table(board)
  end

  public
  def print_grid
    print_table(mines_grid)
  end

  public
  def print_table(table)
    puts
    (0..(table.size-1)).each { |row|
      (0..(table.size-1)).each { |position|
        print table[row][position].to_s + ' '
      }
      puts
    }
  end

  private
  # returns how many mines are around the given location
  def number_mines(row, col)
    sum = 0
    if inside_grid?(row,col)
      nearby_elements(row,col).each{ |nearby_elem_row, nearby_elem_col|
        sum += mines_grid[nearby_elem_row][nearby_elem_col]
      }
      sum

    else
      -1
    end

  end

  private
  def inside_grid?(row, col)
    if (!row.between?(0, mines_grid.size-1)) || (!col.between?(0, mines_grid.size-1))
      false

    else
      true

    end
  end

  # returns all nearby elements of position (row, col) in form of an array
  # containing arrays [row, col]
  private
  def nearby_elements(row, col)
    nearby_elements = Array.new
    (row-1..row+1).each { |current_row|
      (col-1..col+1).each { |current_col|
        if inside_grid?(current_row, current_col)
          nearby_elements.push([current_row, current_col])
        end
      }
    }
    # delete the row, col element because he is not near himself
    nearby_elements.delete_if{|nearby_elem_row, nearby_elem_col|
      nearby_elem_row==row && nearby_elem_col==col
    }

  end




end
