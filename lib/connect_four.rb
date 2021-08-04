module ConnectFour
  def self.run
    true
  end
end



# -----------------------------------------------------------
#  Class Gameboard
#  --> creates multi-dimensional 8x8 gameboard array with dots as default values
#  --> prints current state of the gameboard 
#  
#   Player x > 3      
 
#   1 2 3 4 5 6 7 8
#   . . . . . . . .
#   . . . . . . . .
#   . . . . . . . .
#   . . . . . . . .
#   . . . . . . . .
#   . . . . . . . .
#   . . . . . . . .
#   . . . . . . . .
#

class Gameboard

  # method that creates initial gameboard array
  def create_gameboard(x, y, default)

    gameboard = Array.new(x)
  
    for i in 0...x
        gameboard[i] = Array.new(y, default)
    end
  
    return gameboard
  
  end

  # method that prints current state of the gameboard
  def print_gameboard(z)
    puts ("1 2 3 4 5 6 7 8")

    for x in z
      for y in x
         
        printf "%s ", y
      end
      puts ""
    end
    puts ""
  end
  
end



# -----------------------------------------------------------
#  Class Move
#  --> searches for next empty spot in column and replaces the "." with "x" or "o"
#  --> returns changed gameboard 

class Move

  def splitGameboard(y, x)
    x = (x + (y.length))/2
    return x
  end

  #search for next empty spot in column
  def move(gameboard, x, column, colour)

    x = splitGameboard(gameboard, x) 
    
    if (x+1)<8 
      if gameboard[x][column] == "."
        if gameboard[x+1][column] == "."
          move(gameboard, x, column, colour)
        else
          gameboard[x][column] = colour
        end
      else
        if gameboard[x-1][column] == "."
          gameboard[x-1][column] = colour
        else
          move(gameboard, -x, column, colour)
        end

      end
    else
      gameboard[x][column] = colour
    end
    return gameboard
  end
end


# -----------------------------------------------------------
#  Class WinnerDetection
#  -->
#

class WinnerDetection

end





# -----------------------------------------------------------
# New game
# --> Starts new game








=begin 

# if __FILE__ == $0 
#puts "Welcome! Please insert your Name: "
#name = gets

=end


