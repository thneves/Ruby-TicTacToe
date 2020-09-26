
module NamingPlayers
  def insert_names
  puts "Insert PLAYER 1 name:"
  $player_one = gets.chomp
  puts "Insert PLAYER 2 name:"
  $player_two = gets.chomp
  end
end

class Game

  include NamingPlayers

  attr_accessor :board, :player1, :player2

  X = 'x'
  O = 'o'

  def initialize(player1, player2)
   
   #game variables
    @player1 = player1
    @player2 = player2
    @spot = nil 
    @marked_spot = nil
    @turn = nil
    @board = "\n[ #{1} ] [ #{2} ] [ #{3} ]\n[ #{4} ] [ #{5} ] [ #{6} ]\n[ #{7} ] [ #{8} ] [ #{9} ]\n\n"
    @spots = [1,2,3,4,5,6,7,8,9]


    puts "WELCOME TO THE CLASSIC TIC TAC TOE"
    puts "PLAYER 1 is 'X' and PLAYER 2 is 'O'"
  end

    def naming
      insert_names
      @player1 = $player_one
      @player2 = $player_two
      puts "\nLet the fun begin!"
    end
    
    def display_board
     
      @turn = @player1
      @spot = X
      winner = false
      draw = false
      rounds = 0
      regex = /[0-9]/
     
      while winner == false

      player_turn = "\n>>> #{@turn} TURN! <<<\nDigit the number to mark your '#{@spot}' spot"

      puts player_turn
      puts @board
      @marked_spot = gets.chomp ##getting input from user to check the spot, convert it to a number
          
      if @marked_spot =~ regex

        @marked_spot = @marked_spot.to_i
                
        if (@marked_spot <= 9 || @marked_spot >= 1) && @spots.include?(@marked_spot) == true
          @board["#{@marked_spot}"] = @spot ##check for the input in the visual grid and replace for 'X' or 'O', which will be stored in '@spot'
          @spots[@marked_spot - 1] = @spot  ##Take the user input and replace its number in the array that is used to check the winner for the 'X' or 'O'(this is the grid"backend" just for evaluation) 
        else
          unless (@marked_spot <= 9 || @marked_spot >= 1) && @spots.include?(@marked_spot) == true
            puts "Digit a valid number"
            @marked_spot = gets.chomp.to_i
          end
          @board["#{@marked_spot}"] = @spot
          @spots[@marked_spot - 1] = @spot
         end
      else
        @marked_spot = @marked_spot.to_i
        unless (@marked_spot <= 9 || @marked_spot >= 1) && @spots.include?(@marked_spot) == true
          puts "Digit a number"
          @marked_spot = gets.chomp.to_i
        end
        @board["#{@marked_spot}"] = @spot
        @spots[@marked_spot - 1] = @spot
      end

        ## changing players each turn and their respectives marks like 'X' and 'o'

      if @turn == @player1
        @turn = @player2
        @spot = O
      else
        @turn = @player1
        @spot = X
      end

     ## WINNER CASES, 123, 456, 789, 147, 159, 258, 369, 357
     ## WINNER CASES INDEXES, 012  345  678  036, 048, 147, 258, 246   
     
     if @spots[0] == 'x' && @spots[1] == 'x' && @spots[2] == 'x' || @spots[0] == 'o' && @spots[1] == 'o' && @spots[2] == 'o'
       winner = true
     elsif @spots[3] == 'x' && @spots[4] == 'x' && @spots[5] == 'x' || @spots[3] == 'o' && @spots[4] == 'o' && @spots[5] == 'o'
       winner = true
     elsif @spots[6] == 'x' && @spots[7] == 'x' && @spots[8] == 'x' || @spots[6] == 'o' && @spots[7] == 'o' && @spots[8] == 'o'
       winner = true
     elsif @spots[0] == 'x' && @spots[3] == 'x' && @spots[6] == 'x' || @spots[0] == 'o' && @spots[3] == 'o' && @spots[6] == 'o'
       winner = true
     elsif @spots[0] == 'x' && @spots[4] == 'x' && @spots[8] == 'x' || @spots[0] == 'o' && @spots[4] == 'o' && @spots[8] == 'o'
       winner = true
     elsif @spots[1] == 'x' && @spots[4] == 'x' && @spots[7] == 'x' || @spots[1] == 'o' && @spots[4] == 'o' && @spots[7] == 'o'
       winner = true
     elsif @spots[1] == 'x' && @spots[4] == 'x' && @spots[7] == 'x' || @spots[1] == 'o' && @spots[4] == 'o' && @spots[7] == 'o'
       winner = true
     elsif @spots[2] == 'x' && @spots[5] == 'x' && @spots[8] == 'x' || @spots[2] == 'o' && @spots[5] == 'o' && @spots[8] == 'o'
       winner = true
     elsif @spots[2] == 'x' && @spots[4] == 'x' && @spots[6] == 'x' || @spots[2] == 'o' && @spots[4] == 'o' && @spots[6] == 'o'
       winner = true
     end

       ## Possible draw

     draw = false
    
     rounds += 1
     if rounds == 9
      draw = true
      winner = true
     end
     puts "#{rounds} ROUNDS" 
  end



  if winner == true
    puts @board
    if draw == true
      puts "It's a DRAW! :)"
    elsif @turn == player1
     puts "#{@player2} is the WINNER! CONGRATULATIONS"
    else
      puts "#{@player1} is the WINNER! CONGRATULATIONS!"
    end
      
    puts "Play again? 'Y'/'N' ?"
    reset_game = gets.chomp.upcase
      unless reset_game == 'Y' || reset_game == 'N'
        puts "Digit 'Y' or 'N'"
        reset_game = gets.chomp.upcase
      end
  end

  if reset_game == 'Y'
    winner = false
    @spot = nil 
    @marked_spot = nil
    @turn = nil
    @board = "\n[ #{1} ] [ #{2} ] [ #{3} ]\n[ #{4} ] [ #{5} ] [ #{6} ]\n[ #{7} ] [ #{8} ] [ #{9} ]\n\n"
    @spots = [1,2,3,4,5,6,7,8,9]
    count = 0
    insert_names
    display_board
  else
    puts "Thanks for playing! See ya!"
  end

 end
end


game = Game.new('player1','player2')
game.naming
game.display_board



## Check if the player input is a valid number for the grid and put a message to the user make a valid input! - DONE
## Make the next turn with the board changed and the player name changed - DONE
## evalute which SPOTS were already marked - DONE
## create a way to verify for a winner - DONE
## at the end reset or exit - 
## fix input bug