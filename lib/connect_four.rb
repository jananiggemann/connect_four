module ConnectFour

  # Starts new game by calling the method "moveMaker" up to 64 times 
  def self.run
    64.times do NewGame.moveMaker end
    true
  end

  # ---------------------------------------------------------------------------------
  # Class Gameboard:
  #  --> Creates multi-dimensional 8x8 game board array with dots as default values
  #      Example:
  #
  #      Exit game with key 'x'
  #
  #
  #      1 2 3 4 5 6 7 8
  #      . . . . . . . .
  #      . . . . . . . .
  #      . . . . . . . .
  #      . . . . . . . .
  #      . . . . . . . .
  #      . . . . . . . .
  #      . . . . . . . .
  #      . . . . . . . .
  #
  #  --> Prints current state of the game board
  class Gameboard

    # Creates initial game board array
    def create_gameboard(x, y, default)

      gameboard = Array.new(x)
    
      for i in 0...x
          gameboard[i] = Array.new(y, default)
      end
      return gameboard
    
    end

    # Prints current state of the game board
    def print_gameboard(gameboard)

      # Clears terminal screen after each move so that in case of any changes
      # on the game board.
      # The old one will be replaced by the updated game board.
      system "cls"
      system "clear"

      print ("\n    Exit game with key 'x'\n\n\n       1 2 3 4 5 6 7 8\n       ")
      for line in gameboard
        for field in line
          printf "%s ", field
        end
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
  class WinnerDetection

    WinnerGameboard = Gameboard.new

    # Method prints last move and which player has won, then exits the game.
    def winner(lastMove, xo)
      WinnerGameboard.print_gameboard(lastMove)
      print "\n      Player ", xo, " is the winner!\n\n"
      exit
    end

    # Method takes current state of the game board and the position of the last move.
    # Checks all neighboring positions for same colour (x or o).
    def detectVictory(gameState, line, column, colour)
      # checks vertically down
      x = 0
      for i in 1..3
        if line+i < 8 && gameState[line+i][column] == colour
          x+=1
          if x == 3
            winner(gameState, colour)
          end
        end
      end
    
      # checks horizontally right
      x = 0
      for i in 1..3
        if column+i < 8 && gameState[line][column+i] == colour
          x+=1
          if x == 3
            winner(gameState, colour)
          end
        end
      end
      # checks horizontally left
      x = 0
      for i in 1..3
        if column-i > -1 && gameState[line][column-i] == colour
          x+=1
          if x == 3
            winner(gameState, colour)
          end
        end
      end
      # checks diagonally up left
      x = 0
      for i in 1..3
        if column-i > -1 && line-i > -1 && gameState[line-i][column-i] == colour
          x+=1
          if x == 3
            winner(gameState, colour)
          end
        end
      end
      # checks diagonally down left
      x = 0
      for i in 1..3
        if column-i > -1 && line+i < 8 && gameState[line+i][column-i] == colour
          x+=1
          if x == 3
            winner(gameState, colour)
          end
        end
      end
      # checks diagonally down right
      x = 0
      for i in 1..3
        if column+i < 8 && line+i < 8 && gameState[line+i][column+i] == colour
          x+=1
          if x == 3
            winner(gameState, colour)
          end
        end
      end
      # checks diagonally up right
      x = 0
      for i in 1..3
        if column+i < 8 && line-i > -1 && gameState[line-i][column+i] == colour
          x+=1
          if x == 3
            winner(gameState, colour)
          end
        end
      end
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

    # Searches for next empty spot in column
    def move(gameboard, column, colour)
      d=gameboard.length
      d= d.to_i
      
      for i in 1..8 
        if gameboard[d-i][column] == "."
          gameboard[gameboard.length-i][column] = colour
          NewWinnerDetection.detectVictory(gameboard, gameboard.length-i, column, colour)
          return gameboard
        else
          i+=1
        end
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
      return @@movecount
    end
    
    # Replaces previous game board with an updated version including the last move
    def updateGameboard(move)
      @@gameboard = move
      return @@gameboard
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
      mc = moveCounter(1)
      colour = if mc.even? then "o" else "x" end  
      
      print "\n  --> Press key 1-8 to pick a column\n\n      Player ", colour, " > "

      column = inputRange(colour)

      move = NewMove.move(@@gameboard, column, colour)
      
      print "\n\n"
      NewGameboard.print_gameboard(move)
      if @@movecount == 64
        print "\n      No winner! Game over.\n\n"
        exit
      end
      updateGameboard(move)
    end
  end


  # ---------------------------------------------------------------------------------
  # New Game:
  # --> Creates new object of the class "Game"
  NewGame = Game.new

end