require 'pry-byebug'
# binding.pry


class Game

    attr_accessor 
    attr_reader
    attr_writer

    def initialize()
        puts @@introduction
        updateFieldView("")
    end

    private

    @@introduction = "
    The Tic-Tac-Toe Game\n
    Instructions:
    In order to select your square, please give the row and column indices.
    For example, to select the second square on the first row, you would enter '1, 2'.
    1 is the row number and 2 is the column number.
    The rest of the game is just Tic-Tac-Toe.\n 
    This is your field, let play!
    "

    @@empty = "-"
    @@cross = "X"
    @@circle = "O"
    @@field = "#{@@empty} #{@@empty} #{@@empty}\n#{@@empty} #{@@empty} #{@@empty}\n#{@@empty} #{@@empty} #{@@empty}"
    @@field_array = [[@@empty, @@empty, @@empty], [@@empty, @@empty, @@empty], [@@empty, @@empty, @@empty]]
    @@field_availability = [[true, true, true], [true, true, true], [true, true, true]]
    @@circle_turn = true

    def updateFieldView(move)
        if (move != "") then 
        @@circle_turn ? @@field_array[move[0].to_i-1][move[1].to_i-1] = @@circle : @@field_array[move[0].to_i-1][move[1].to_i-1] = @@cross
        @@field_availability[move[0].to_i-1][move[1].to_i-1] = false
        end
        @@circle_turn = !@@circle_turn
        @@field = "\n"
        @@field_array.each do |row|
          row.each do |item|
            @@field += "#{item} "
          end
          @@field += "\n"
        end
        @@field += "\n"
        puts @@field
        @@circle_turn ? getInput("Circle") : getInput("Cross")
    end

    def getInput(player)
        puts "#{player} Player, make your move:"
        move = gets.chomp
        # binding.pry
        move = checkInput(move)
        validMove = checkAvailable(move.split(", "))
        updateFieldView(validMove)
    end

    def checkInput(move)
        until move.match(/[1-3], [1-3]/)
            puts "Please, enter a valid position, such as '1, 2'."
            move = gets.chomp
        end
        move
    end
        
    def checkAvailable(move)
        until @@field_availability[move[0].to_i-1][move[1].to_i-1] == true
            puts @@field
            puts "Please choose a free position"
            move = gets.chomp
            move = checkInput(move)
            move = move.split(", ")
        end
        move
    end
end

def play()
    tic_tac_toe = Game.new
end

play()