require_relative 'game.rb'

def play
    tic_tac_toe = Game.new
    tic_tac_toe.play
    play_again = gets.chomp.downcase
    play_again == "y" ? play : puts("Thanks for playing!")
end

play