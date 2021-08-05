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
#
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

  # method that searches for next empty spot in column
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
# Class game
# --> Creates new object of the class "Gameboard" and prints it
# --> Creates new object of the class "Move"
#

class Game
  NewGameboard = Gameboard.new
  @@gameboard = NewGameboard.create_gameboard(8, 8, ".")
  NewGameboard.print_gameboard(@@gameboard)

  colour = ""
  @@movecount = 0


  def moveCounter
    @@movecount +=1
    print "\n(MoveCounter: ", @@movecount, ")\n\n"
    return @@movecount
  end

  def gameboard(move)
    @@gameboard = move
    return @@gameboard
  end

  def inputRange
    a = gets
    a = (a.to_i)-1

    if a>-1 && a<8 
      column = a 
      return column
    else
      print "Wrong input. Press key between 1 and 8: "
      inputRange
    end
  end

  NewMove = Move.new

  # method "moveMaker" gets the input from player, decides which players turn it is and gets the updated gameboard from class "Move"
  def moveMaker

    mc = moveCounter
    colour = if mc.even? then "o" else "x" end  
    
    print "Player: ", colour, "\n\nPress key 1-8 to pick a column: "

    column = inputRange

    move = NewMove.move(@@gameboard, 0, column, colour)
    print "\nplayer ", colour ," > ", column+1 ,"\n\n"
    NewGameboard.print_gameboard(move)
    gameboard(move)

  end
end



# -----------------------------------------------------------
# New game
# --> Starts new game
# --> Creates new object of the class "Game"

NewGame = Game.new

for i in 1..10 do
  moveOnce = NewGame.moveMaker
end








=begin 

# if __FILE__ == $0 
#puts "Welcome! Please insert your Name: "
#name = gets

=end


