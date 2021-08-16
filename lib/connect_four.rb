require 'io/console'

module ConnectFour
  # Starts new game by calling the method "moveMaker" up to 64 times 
  def self.run
    $newGame = Game.new
    64.times do $newGame.moveMaker end
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
    def detectVictory(l)
      # checks vertically down
      i=1
      while i<4 && l+i<8 && $gameboard[l+i][$col]== $x_or_o do i+=1 end
      if i==4 then winner() end
      
      # checks horizontally right and then left
      i=1
      while i<4 && $col+i<8 && $gameboard[l][$col+i]== $x_or_o do i+=1 end
      x=1
      while i+x<5 && $col-x>-1 && $gameboard[l][$col-x]== $x_or_o do x+=1 end
      if i+x==5 then winner() end

      # checks diagonally down left and then up right
      i=1
      while i<4 && $col-i>-1 && l+i<8 && $gameboard[l+i][$col-i]== $x_or_o do i+=1 end
      x=1
      while i+x<5 && $col+x<8 && l-x>-1 && $gameboard[l-x][$col+x]== $x_or_o do x+=1 end
      if i+x==5 then winner() end

      # checks diagonally down right and then up left
      i=1
      while i<4 && $col+i<8 && l+i<8 && $gameboard[l+i][$col+i]== $x_or_o do i+=1 end
      x=1
      while i+x<5 && $col-x>-1 && l-x>-1 && $gameboard[l-x][$col-x]== $x_or_o do x+=1 end
      if i+x==5 then winner() end
    end

    # Method "winner" prints last move and which player has won, then exits the game.
    def winner
      $newGameboard.print_gameboard($gameboard)
      print "\n    Player ", $x_or_o, " is the winner!\n\n"
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
    def move
      newWinnerDetection = WinnerDetection.new
      d=$gameboard.length
      d= d.to_i
      
      for i in 1..8 
        if $gameboard[d-i][$col] == "."
          $gameboard[d-i][$col] = $x_or_o
          newWinnerDetection.detectVictory(d-i)
          return
        end
        i+=1
      end 
      print "\n      Choose different Column!\n"
      $movecount-=1
      $newGame.moveMaker
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
    $newGameboard = Gameboard.new
    $gameboard = $newGameboard.create_gameboard(8, 8, ".")

    # Counts how many moves have been made so its possible to know whose turn it is
    $movecount = 0

    # Gets the user input, converts it to integer and checks if its within 1-8.
    # If its not within that range, the method calls itself again.
    def inputRange
      a = STDIN.getch
      print a
      sleep(0.2)
      if a.to_i>0 && a.to_i<9
        $col = a.to_i-1
        return 
      elsif a == "x"
        print "\n\n\n"
        exit
      else
        print "\n      Wrong input! Press key between 1 and 8\n\n      Player ", $x_or_o, " > "
        inputRange()
      end
    end

    # Gets the input from player, decides which players turn it is 
    # and gets the updated game board from class "Move".
    def moveMaker
      $newGameboard.print_gameboard($gameboard)
      newMove = Move.new
      $movecount+=1
      $x_or_o = if $movecount.even? then "o" else "x" end  
      print "\n  --> Press key 1-8 to pick a column\n\n      Player ", $x_or_o, " > "
      inputRange()
      newMove.move
    end
  end
end