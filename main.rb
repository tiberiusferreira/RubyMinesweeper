


class Grid

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
    puts zeros.inspect

    @grid
  end





end
grid = Grid.new(4, 2)
