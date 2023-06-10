require_relative 'display.rb'
require_relative 'player.rb'
require_relative 'board.rb'

class Game
    include Display
    # attr_reader :player1, :player2

    def initialize
        show_intro
        @player1 = nil
        @player2 = nil
        @board = Board.new
        @current_player = nil
        @game_over = false
    end

    def play
        game_setup
        @board.show
        play_turns
        show_play_again
    end

    private

    def game_setup
        @player1 = create_player(1)
        @player2 = create_player(2, @player1.symbol)
    end

    def create_player(number, otherSymbol = nil)
        player_name_prompt(number)
        name = gets.chomp
        symbol = get_symbol(name, otherSymbol)
        Player.new(name, symbol)
    end

    def get_symbol(name, otherSymbol)
        player_symbol_prompt(name, otherSymbol)
        symbol = gets.chomp
        return symbol if symbol.match?(/^[^0-9]$/) && symbol != otherSymbol

        show_input_error
        get_symbol(name, otherSymbol)
    end

    def play_turns
        @current_player = @player1
        until @game_over do
            player_turn_prompt(@current_player.name)
            move = gets.chomp
            move = validate_move(move)
            @board.update(move-1, @current_player.symbol)
            @board.show
            check_game_over
            switch_current_player
        end
    end

    def validate_move(move)
        move = check_move_input(move.to_s).to_i
        return move if @board.board[move-1].is_a? Integer

        show_move_error
        move = gets.chomp
        validate_move(move)
    end

    def check_move_input(move)
        return move if move.match?(/[1-9]/)

        show_input_error
        move = gets.chomp
        check_move_input(move)
    end

    def switch_current_player
        @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
    end

    def check_game_over
        if @board.check_winner
            @game_over = true
            return show_winner(@current_player.name, @current_player.symbol)
        elsif @board.full?
            @game_over = true
            show_no_winner
        end
    end
end