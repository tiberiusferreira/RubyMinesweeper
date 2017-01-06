


class Grid
  def grid
    @grid
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
    @grid = zeros.each_slice(m).to_a
  end

  # returns how many mines are around the given location
  def number_mines(row, col)
    sum = 0
    if inside_grid?(row,col)
      nearby_elements(row,col).each{ |nearby_elem_row, nearby_elem_col|
        sum += grid[nearby_elem_row][nearby_elem_col]
      }
      sum

    else
      -1
    end

  end


  def inside_grid?(row, col)
    if (!row.between?(0, @grid.size-1)) || (!col.between?(0, @grid.size-1))
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

end

grid = Grid.new(4, 8)
grid.grid.each { |row|
  puts row.inspect
}

puts grid.number_mines(0, 0)
