module ConnectFour

  # --> Starts new game
  def self.run
    64.times do NewGame.moveMaker end
    true
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

      #clears terminal screen after each move
      system "cls" && "clear"

      puts ("\nExit game with key 'x'\n\n\n1 2 3 4 5 6 7 8")

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
  #  Class WinnerDetection


  class WinnerDetection

    WinnerGameboard = Gameboard.new

    # method prints last move, which player has won and exits the game
    def winner(board, colour)
      WinnerGameboard.print_gameboard(board)
      print "\nPlayer ", colour, " is the winner!\n\n"
      exit
    end
    
    # method takes current state of the gameboard and the position of the last move
    # checks all neighboring positions for same colour
    def detectVictory(gameState, line, column, colour)
      i = 1
      3.times do
        # checks vertically down
        while line+i < 8 && gameState[line+i][column] == colour
          i+=1
          if i == 4
            winner(gameState, colour)
          end
        end
        # checks horizontally right
        while column+i < 8 && gameState[line][column+i] == colour
          i+=1
          if i == 4
            winner(gameState, colour)
          end
        end
        # checks horizontally left
        while column-i > -1 && gameState[line][column-i] == colour
          i+=1
          if i == 4
            winner(gameState, colour)
          end
        end
        # checks diagonally up left
        while column-i > -1 && line-i > -1 && gameState[line-i][column-i] == colour
          i+=1
          if i == 4
            winner(gameState, colour)
          end
        end
        # checks diagonally down left
        while column-i > -1 && line+i < 8 && gameState[line+i][column-i] == colour
          i+=1
          if i == 4
            winner(gameState, colour)
          end
        end
        # checks diagonally down right
        while column+i < 8 && line+i < 8 && gameState[line+i][column+i] == colour
          i+=1
          if i == 4
            winner(gameState, colour)
          end
        end
        # checks diagonally up right
        while column+i < 8 && line-i > -1 && gameState[line-i][column+i] == colour
          i+=1
          if i == 4
            winner(gameState, colour)
          end
        end
      end
    end
  end



  # -----------------------------------------------------------
  #  Class Move
  #  --> searches for next empty spot in column and replaces the "." with "x" or "o"
  #  --> returns changed gameboard 

  class Move

    # method that searches for next empty spot in column
    NewWinnerDetection = WinnerDetection.new
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
      print "Chose different Column:"
      NewGame.moveCounter(-1)
      NewGame.moveMaker
    end
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

    @@movecount = 0

    def moveCounter(x)
      @@movecount +=x
      #print "\n(MoveCounter: ", @@movecount, ")\n\n"
      return @@movecount
    end

    def gameboard(move)
      @@gameboard = move
      return @@gameboard
    end

    def inputRange
      a = gets.chomp

      if a.to_i>0 && a.to_i<9
        column = a.to_i-1
        return column
      elsif a == "x"
        exit
      else
        print "Wrong input. Press key between 1 and 8: "
        inputRange
      end
    end


    NewMove = Move.new
    # method "moveMaker" gets the input from player, decides which players turn it is and gets the updated gameboard from class "Move"
    def moveMaker
      mc = moveCounter(1)
      colour = if mc.even? then "o" else "x" end  
      
      print "\nPress key 1-8 to pick a column:\n\nPlayer ", colour, " > "

      column = inputRange

      move = NewMove.move(@@gameboard, column, colour)
      
      print "\n\n"
      NewGameboard.print_gameboard(move)
      gameboard(move)
    end
  end


  # -----------------------------------------------------------
  # New game
  # --> Creates new object of the class "Game"
  NewGame= Game.new

end