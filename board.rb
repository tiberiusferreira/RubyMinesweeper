

class Board
  def mines_grid
    @mines_grid
  end

  def board
    @board
  end

  # n = size of grid (NxN)
  # m = number of mines
  def initialize(m, n)
    # create a linear array with zeros representing all the places that do not contain mines
    zeros = Array.new(m*m-n, 0)
    # create a linear array representing the mines (ones)
    ones = Array.new(n,1)
    # merge the two into another linear array
    zeros.concat(ones).shuffle!
    # split the array into smaller ones of same size representing the grid lines
    @mines_grid = zeros.each_slice(m).to_a
    update_board
  end

  def update_board
    @board = Array.new(mines_grid.size){Array.new(mines_grid.size)}
    (0..board.size-1).each { |row|
      (0..board.size-1).each{ |col|
        if mines_grid[row][col] == 1
          board[row][col] = 'B'
        else
          board[row][col] = number_mines(row,col)
        end
      }
    }
  end

  def print_board
    puts
    board.each { |row|
      puts row.inspect
    }
    puts
  end
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


  def inside_grid?(row, col)
    if (!row.between?(0, @mines_grid.size-1)) || (!col.between?(0, @mines_grid.size-1))
      false

    else
      true

    end
  end

  # returns all nearby elements of position (row, col) in form of an array
  # containing arrays [row, col]
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

  def print_grid
    puts
    mines_grid.each { |row|
      puts row.inspect
    }
    puts
  end



end
