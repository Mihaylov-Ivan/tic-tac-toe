require 'pry-byebug'
# binding.pry

class Game
    @@game_over = false
    @@circle_turn = false
    @@winner = ""

    def initialize
        puts @@introduction
        puts @@field
    end

    def self.game_over 
        @@game_over
    end
    def self.circle_turn
        @@circle_turn
    end
    def self.winner
        @@winner
    end

    protected
    def makeAMove
        move = gets.chomp
        move = checkInput(move)
        validMove = checkAvailable(move.split(", "))
        updateFieldView(validMove)
        checkWinner
    end

    private
    @@introduction = "
    The Tic-Tac-Toe Game\n
    Instructions:
    In order to select your square, please give the row and column indices.
    For example, to select the second square on the first row, you would enter '1, 2'.
    1 is the row number and 2 is the column number.
    The rest of the game is just Tic-Tac-Toe.\n 
    Let play!
    "

    @@empty = "-"
    @@cross = "X"
    @@circle = "O"
    
    @@field = "- - -\n- - -\n- - -"
    @@field_array = [["-", "-", "-"], ["-", "-", "-"], ["-", "-", "-"]]
    @@placed_crosses = [["-", "-", "-"], ["-", "-", "-"], ["-", "-", "-"]]
    @@placed_circles = [["-", "-", "-"], ["-", "-", "-"], ["-", "-", "-"]]
    @@field_availability = [[true, true, true], [true, true, true], [true, true, true]]
    @@win_combos = [
        [["X", "X", "X"], ["-", "-", "-"], ["-", "-", "-"]],
        [["-", "-", "-"], ["X", "X", "X"], ["-", "-", "-"]],
        [["-", "-", "-"], ["-", "-", "-"], ["X", "X", "X"]],
        [["X", "-", "-"], ["X", "-", "-"], ["X", "-", "-"]],
        [["-", "X", "-"], ["-", "X", "-"], ["-", "X", "-"]],
        [["-", "-", "X"], ["-", "-", "X"], ["-", "-", "X"]],
        [["X", "-", "-"], ["-", "X", "-"], ["-", "-", "X"]],
        [["-", "-", "X"], ["-", "X", "-"], ["X", "-", "-"]],
    ]

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

    def updateFieldView(move)
        @@circle_turn ? @@field_array[move[0].to_i-1][move[1].to_i-1] = @@circle : @@field_array[move[0].to_i-1][move[1].to_i-1] = @@cross
        @@circle_turn ? @@placed_circles[move[0].to_i-1][move[1].to_i-1] = @@circle : @@placed_crosses[move[0].to_i-1][move[1].to_i-1] = @@cross
        @@field_availability[move[0].to_i-1][move[1].to_i-1] = false
        @@field = "\n"
        @@field_array.each do |row|
          row.each do |item|
            @@field += "#{item} "
          end
          @@field += "\n"
        end
        @@field += "\n"
        puts @@field
    end

    def checkWinner
        @@win_combos.each do |combo|
            if @@circle_turn then
                combo.each {|row| row.map! {|item| item == "X" ? "O" : item}}
                if combo == @@placed_circles then
                    @@game_over = true
                    @@winner = "Circle"
                else next
                end
            else
                combo.each {|row| row.map! {|item| item == "O" ? "X" : item}}
                if combo == @@placed_crosses then
                    @@game_over = true
                    @@winner = "Cross"
                else next
                end
            end
        end
        @@circle_turn = !@@circle_turn
    end
end

class Player < Game
    attr_reader :name

    def initialize(name, symbol)
        @name = "#{name} (#{symbol})"
    end

    def makeAMove
        puts "#{@name}, make your move:"
        super
    end

    def declareWinner
        puts "Congratulations #{@name}! You are the winner!"
    end
end

def play()
    puts "Cross player, what is your name?"
    crossName = gets.chomp
    puts "Circle player, what is your name?"
    circleName = gets.chomp

    tic_tac_toe = Game.new
    cross = Player.new(crossName, "Cross")
    circle = Player.new(circleName, "Circle")

    until Game.game_over == true
        Game.circle_turn ? circle.makeAMove : cross.makeAMove
    end
    Game.winner == "Cross" ? cross.declareWinner : circle.declareWinner
end

play()