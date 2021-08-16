require 'io/console'

module ConnectFour
  # Starts new game by calling the method "moveMaker" up to 64 times 
  def self.run
    64.times do NewGame.moveMaker end
    print "\n      No winner! Game over.\n\n"
    exit
  end


  # ---------------------------------------------------------------------------------
  # Class Gameboard:
  #  --> Creates multi-dimensional 8x8 game board array with dots as default values
  #  --> Prints current state of the game board
  #      Example:
  #
  #          Exit game with key 'x'
  #
  #
  #             1 2 3 4 5 6 7 8
  #             . . . . . . . .
  #             . . . . . . . .
  #             . . . . . . . .
  #             . . . . . . . .
  #             . . . . . . . .
  #             . . . . . . . .
  #             . . . . . . . .
  #             . . . . . . . .
  #
  class Gameboard
    # Creates initial game board array
    def create_gameboard(x, y, default)
      gameboard = Array.new(x)
      for i in 0...x do gameboard[i] = Array.new(y, default) end
      return gameboard
    end

    # Prints current state of the game board, the old one will be replaced by the 
    # updated game board.
    def print_gameboard(gameboard)
      # Clears terminal screen after each move so that in case of any changes
      # on the game board.
      system "cls"
      system "clear"

      print ("\n    Exit game with key 'x'\n\n\n       1 2 3 4 5 6 7 8\n       ")
      for line in gameboard
        for field in line do printf "%s ", field end
        print "\n       "
      end
      puts ""
    end
  end


  # ---------------------------------------------------------------------------------
  # Class WinnerDetection:
  #  --> Checks after each move if 4 tokens of the same colour (x or o)
  #      have been connected 
  #  --> If thats the case, the final state of the game board is printed and the 
  #      winner is announced
  # Method "detect Victory":
  #  --> Takes current state of the game board and the position of the last move.
  #  --> Checks all neighboring positions for same colour (x or o).
  #  If there are fields of the same colour on both sides 
  #  (right and left, diagonally up and down), the counter variable i is not reset 
  #  to default value after checking one side. i is added to counter variable x when 
  #  checking the other side, so that insertions between 3 fields of the same colour
  #  are recognized as winning.
  #  E.g. horizontally right and then left:
  #  If i==2 after the first while loop, it means that there is a field of 
  #  the same colour on the right side. 
  #  In that case, the "left side" while loop is executed up to 2 times, in case 
  #  there are 2 fields of the same colour on the left side.
  class WinnerDetection
    def detectVictory(gameState, l, col, xo)
      # checks vertically down
      i=1
      while i<4 && l+i<8 && gameState[l+i][col]== xo do i+=1 end
      if i==4 then winner(gameState, xo) end
      
      # checks horizontally right and then left
      i=1
      while i<4 && col+i<8 && gameState[l][col+i]== xo do i+=1 end
      x=1
      while i+x<5 && col-x>-1 && gameState[l][col-x]== xo do x+=1 end
      if i+x==5 then winner(gameState, xo) end

      # checks diagonally down left and then up right
      i=1
      while i<4 && col-i>-1 && l+i<8 && gameState[l+i][col-i]== xo do i+=1 end
      x=1
      while i+x<5 && col+x<8 && l-x>-1 && gameState[l-x][col+x]== xo do x+=1 end
      if i+x==5 then winner(gameState, xo) end

      # checks diagonally down right and then up left
      i=1
      while i<4 && col+i<8 && l+i<8 && gameState[l+i][col+i]== xo do i+=1 end
      x=1
      while i+x<5 && col-x>-1 && l-x>-1 && gameState[l-x][col-x]== xo do x+=1 end
      if i+x==5 then winner(gameState, xo) end
    end

    # Method "winner" prints last move and which player has won, then exits the game.
    WinnerGameboard = Gameboard.new
    def winner(lastMove, xo)
      WinnerGameboard.print_gameboard(lastMove)
      print "\n    Player ", xo, " is the winner!\n\n"
      exit
    end
  end


  # ---------------------------------------------------------------------------------
  #  Class Move:
  #  --> Searches for the next empty spot in the column the player chose and replaces 
  #      the default value with "x" or "o"
  #  --> In case there is no empty space in the chosen column the player can choose
  #      a different one  
  #  --> Returns changed game board 
  class Move
    NewWinnerDetection = WinnerDetection.new
    def move(gameboard, col, xo)
      d=gameboard.length
      d= d.to_i
      
      for i in 1..8 
        if gameboard[d-i][col] == "."
          gameboard[gameboard.length-i][col] = xo
          NewWinnerDetection.detectVictory(gameboard, gameboard.length-i, col, xo)
          return gameboard
        end
        i+=1
      end 
      print "\n      Choose different Column!\n"
      NewGame.moveCounter(-1)
      NewGame.moveMaker
    end
  end


  # ---------------------------------------------------------------------------------
  # Class game:
  #  --> Creates new object of the class "Gameboard" and prints it, so that the 
  #      initial state of the game is displayed
  #  --> Creates new object of the class "Move"
  #  --> Gets the user input and checks if its between 1 and 8, in case its x the 
  #      game is exited
  #  --> Calls method "Move" to to implement players move
  class Game
    # New object of the class "Gameboard" is created and printed in initial state
    NewGameboard = Gameboard.new
    @@gameboard = NewGameboard.create_gameboard(8, 8, ".")
    NewGameboard.print_gameboard(@@gameboard)

    @@movecount = 0

    # Counts how many moves have been made so its possible to know whose turn it is
    def moveCounter(x)
      @@movecount +=x
    end
    
    # Replaces previous game board with an updated version including the last move
    def updateGameboard(move)
      @@gameboard = move
    end

    # Gets the user input, converts it to integer and checks if its within 1-8.
    # If its not within that range, the method calls itself again.
    def inputRange(colour)
      a = STDIN.getch
      print a
      sleep(0.2)
      if a.to_i>0 && a.to_i<9
        column = a.to_i-1
        return column
      elsif a == "x"
        print "\n\n\n"
        exit
      else
        print "\n      Wrong input! Press key between 1 and 8\n\n      Player ", colour, " > "
        inputRange(colour)
      end
    end

    NewMove = Move.new
    # Gets the input from player, decides which players turn it is 
    # and gets the updated game board from class "Move".
    def moveMaker
      colour = if moveCounter(1).even? then "o" else "x" end  
      print "\n  --> Press key 1-8 to pick a column\n\n      Player ", colour, " > "

      move = NewMove.move(@@gameboard, inputRange(colour), colour)
      NewGameboard.print_gameboard(move)
      updateGameboard(move)
    end
  end


  # ---------------------------------------------------------------------------------
  # Creates new object of the class "Game"
  NewGame = Game.new

end