require 'io/console'

module ConnectFour
  # Starts new game by calling the method "move_maker" up to 64 times 
  def self.run
    newGame = Game.new
    while $move_counter<64
      newGame.move_maker
    end
    GameBoard.print_game_board($game_board)
    print "\n\tNo winner! Game over.\n\n"
    exit
  end


  # ---------------------------------------------------------------------------------
  # Class GameBoard:
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
  class GameBoard
    # Creates initial game board array
    def create_game_board(x, y, default)
      game_board = Array.new(x)
      for i in 0...x
        game_board[i] = Array.new(y, default) 
      end
      return game_board
    end

    # Prints current state of the game board, the old one will be replaced by the 
    # updated game board.
    def self.print_game_board(game_board)
      # Clears terminal screen after each move so that in case of any changes
      # on the game board.
      system "cls"
      system "clear"

      print ("\n\tExit game with key 'x'\n\n\n\t   1 2 3 4 5 6 7 8\n\t   ")
      for line in game_board
        for field in line
          printf "%s ", field
        end
        print "\n\t   "
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
  # Method "winner":
  #  --> Calls method "victory?" and passes the line of the last move as an argument
  #  --> If method "victory?" returns 1, the game board is printed one last time, 
  #      the winner is announced and the game ends
  # Method "victory?":
  #  --> Gets the line of the last move as an argument
  #  --> Checks all neighboring positions of the last move 
  #  --> If there are fields of the same colour ($x_or_o) on both sides 
  #      (right and left, diagonally up and down), the counter variable i is not reset 
  #      to default value after checking one side. i is added to counter variable x when 
  #      checking the other side, so that insertions between 3 fields of the same colour
  #      are recognized as winning (returns 1 to "winner")
  #  --> E.g. horizontally right and then left:
  #      If i==2 after the first while loop, it means that there is a field of 
  #      the same colour on the right side. 
  #      In that case, the "left side" while loop is executed up to 2 times, in case 
  #      there are 2 fields of the same colour on the left side.
  class WinnerDetection
    # Method "winner" prints last move and which player has won, then exits the game.
    def winner(l)
      if victory?(l) == "winner"
        GameBoard.print_game_board($game_board)
        print "\n\tPlayer ", $x_or_o, " is the winner!\n\n"
        exit
      end
    end

    def victory?(l)
      # checks vertically down
      i=1
      while i<4 && l+i<8 && $game_board[l+i][$col]== $x_or_o
        i+=1
      end
      if i==4 then return "winner" end
      
      # checks horizontally right and then left
      i=1
      while i<4 && $col+i<8 && $game_board[l][$col+i]== $x_or_o do i+=1 end
      x=1
      while i+x<5 && $col-x>-1 && $game_board[l][$col-x]== $x_or_o
        x+=1 
      end
      if i+x==5 then return "winner" end

      # checks diagonally down left and then up right
      i=1
      while i<4 && $col-i>-1 && l+i<8 && $game_board[l+i][$col-i]== $x_or_o
        i+=1
      end
      x=1
      while i+x<5 && $col+x<8 && l-x>-1 && $game_board[l-x][$col+x]== $x_or_o
        x+=1
      end
      if i+x==5 then return "winner" end

      # checks diagonally down right and then up left
      i=1
      while i<4 && $col+i<8 && l+i<8 && $game_board[l+i][$col+i]== $x_or_o
        i+=1
      end
      x=1
      while i+x<5 && $col-x>-1 && l-x>-1 && $game_board[l-x][$col-x]== $x_or_o
        x+=1 
      end
      if i+x==5 then return "winner" end
    end
  end


  # ---------------------------------------------------------------------------------
  #  Class Move:
  #  --> Searches for the next empty spot in the column the player chose and replaces 
  #      the default value with "x" or "o"
  #  --> calls method "winner" and passes the line of the last move as an argument 
  #      to check if the move completes a sequence of 4 x's or o's
  #  --> Returns changed game board 
  #  --> If there is no empty space in the chosen column ($col), 0 is returned 
  class Move
    def self.check_move
      newWinnerDetection = WinnerDetection.new
      d=$game_board.length
      d= d.to_i
      
      for i in 1..8 
        if $game_board[d-i][$col] == "."
          $game_board[d-i][$col] = $x_or_o
          newWinnerDetection.winner(d-i)
          return 
        end
        i+=1
      end 
      return "column complete"
    end
  end


  # ---------------------------------------------------------------------------------
  # Class game:
  #  --> Creates new object of the class "GameBoard" and prints it, so that the 
  #      initial state of the game is displayed
  #  --> Creates new object of the class "Move"
  #  --> Gets the user input and checks if its between 1 and 8, in case its "x" the 
  #      game is exited
  #  --> Calls method "check_move" to implement players move
  class Game
    # New object of the class "Gameboard" is created and printed in initial state
    $game_board = GameBoard.new.create_game_board(8, 8, ".")
    # Counts how many moves have been made so its possible to know whose turn it is
    $move_counter = 0
    # Gets the user input, converts it to integer and checks if its within 1-8.
    # If its not within that range, the method calls itself again.
    def input_range
      input = STDIN.getch
      print input
      sleep(0.17) #to see player input on console 
      if input.to_i>0 && input.to_i<9
        $col = input.to_i-1
      elsif input == "x"
        print "\n\n\n"
        exit
      else
        print "\n\n\tWrong input! Press key between 1 and 8.\n\n\tPlayer ", $x_or_o, " > "
        input_range()
      end
    end
    
    # Gets the input from player, decides which players turn it is 
    # and gets the updated game board from class "Move".
    # In case there is no empty space in the chosen column the player can choose
    # a different one.
    def move_maker
      GameBoard.print_game_board($game_board)
      $move_counter+=1
      $x_or_o = if $move_counter.even? then "o" else "x" end  
      print "\n    --> Press key 1-8 to pick a column\n\n\tPlayer ", $x_or_o, " > "
      input_range()
      if Move.check_move == "column complete"
        print "\n\n\tChoose different column!"
        $move_counter-=1
        sleep(1)
      end
    end
  end
end