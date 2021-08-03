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

  #def initialize ()  
  #  
  #end

  # method that creates start gameboard array
  def create_gameboard(x, y, default)

    gameboard = Array.new(x)
  
    for i in 0...x
        gameboard[i] = Array.new(y, default)
    end
  
    return gameboard
  
  end

  # method that prints current state of the gameboard
  def print_gameboard(z)
    puts ("\n player ""\n\n")
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


#ng = Game.new(name)





