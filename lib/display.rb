module Display
    def show_intro
        puts "
        The Tic-Tac-Toe Game\n
        Instructions:
        In order to select your square, please give the row and column indices.
        For example, to select the second square on the first row, you would enter '1, 2'.
        1 is the row number and 2 is the column number.
        The rest of the game is just Tic-Tac-Toe.\n 
        Let play!
        "
    end

    def player_name_prompt(number)
        puts "
        Player #{number}, what is your name?
        "
    end

    def player_symbol_prompt(name, otherSymbol)
        puts "#{name}, what is you symbol? (a single symbol or letter)"
        puts "Make sure it is not #{otherSymbol}" if otherSymbol
    end

    def show_input_error
        puts "\e[31mSorry, that is an invalid input. Please, try again.\e[0m"
    end

    def show_move_error
        puts "\e[31mSorry, that is an invalid move. Please, select a free cell.\e[0m"
    end

    def player_turn_prompt(name)
        puts "#{name}, make a move!"
    end

    def show_no_winner
        puts "Game Over! No winner."
    end

    def show_winner(name, symbol)
        puts "Congratulations #{name} (#{symbol})! You are the winner!"
    end

    def show_play_again
        puts "Do you want to play again? (y / n)"
    end

    def show_thanks_for_playing
        puts "Thank you for playing!"
    end
end