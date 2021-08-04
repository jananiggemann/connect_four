module ConnectFour
  def self.run
    true
  end
end


=begin

1. Create basic structure through classes and methods
  - superclass Game
  - subclass Player
  - subclass GameBoard
  - subclass WinnerDetection


=end

# ---------------------------------------------------------
#  superclass Game
#

class Game  

  def initialize (name)  
    @counter += 1 # adds 1 to counter
    @name = name  
  end

end


# ---------------------------------------------------------
#  subclass Player 
# --> creates Player x and Player o 
# --> counts number of players
# --> limits number of players to 2
# --> input of player names

class Player < Game  

  def initialize (name, colour)
    super (name)
    @colour = colour
  end 

  def player_name
    "Name: #{@name}"  
  end

  def player_counter # counts players
    counter = @counter  
  end

  def xo  # sets first player as Player x and second player as Player o
    colour = if player_counter == 1 then "x"; else "o"; end
  end

  def number_of_players
    if player_counter > 2
      puts "Too many Players."
    elseif player_counter < 1
      puts "No Player."
    else
    end
  end

end




# -----------------------------------------------------------
#  Class Gameboard
#  --> creates multi-dimensional 8x8 gameboard array with dots as default values
#  --> prints empty 8x8 gameboard 
#  --> changes gameboard after each move and prints new state
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

  #def initialize (colour)  
  #  @colour = colour
  #end

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

  #gameboard[1][5] = "x"
  
end


# -----------------------------------------------------------
#  Class Move
# --> searches for next empty spot in column and replaces the "." with "x" or "o"
# --> returns changed gameboard 
class Move

  def initialize(colour, column)  
    @colour = colour
    @column = column
  end

  
  def splitGameboard(y, x)
    x = (x + (y.length))/2
    return x
  end

  #binary search for next empty spot in column
  def move(gameboard, x)
    x = splitGameboard(gameboard,x) 
    
    if (x+1)<8 
      if gameboard[x][@column] == "."
        if gameboard[x+1][@column] == "."
          move(gameboard, x)
        else
          gameboard[x][@column] = @colour
        end
      else
        if gameboard[x-1][@column] == "."
          gameboard[x-1][@column] = @colour
        else
          move(gameboard, -x)
        end

      end
    else
      gameboard[x][@column] = @colour
    end
    return gameboard
  end
end


# -----------------------------------------------------------
#  Class WinnerDetection
# -->
#

class WinnerDetection

end


# -----------------------------------------------------------
# start game
#
# if __FILE__ == $0 
#puts "Welcome! Please insert your Name: "
#name = gets


NewGameboard = Gameboard.new
gameboard = NewGameboard.create_gameboard(8, 8, ".")
NewGameboard.print_gameboard(gameboard)

colour = "x"
print "Column: "
column = gets
column = (column.to_i)-1

print "\n player ", colour ," > ", column ,"\n"

NewMove = Move.new(colour, column)
move = NewMove.move(gameboard, 0)
NewGameboard.print_gameboard(move)





#ng = Game.new(name)





