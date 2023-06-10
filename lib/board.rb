class Board

    attr_reader :board

    WIN_COMBOS = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6],
    ]

    def initialize
        @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end

    def show
        puts <<-HEREDOC
    
           #{@board[0]} | #{@board[1]} | #{@board[2]}
          ---+---+---
           #{@board[3]} | #{@board[4]} | #{@board[5]}
          ---+---+---
           #{@board[6]} | #{@board[7]} | #{@board[8]}
    
        HEREDOC
    end

    def update(position, symbol)
        @board[position] = symbol
    end

    def full?
        not @board.any? {|cell| cell.is_a?(Integer)}
    end

    def check_winner
        winner = false
        WIN_COMBOS.each do |combo|
            winner = true if [@board[combo[0]], @board[combo[1]], @board[combo[2]]].uniq.length == 1
        end
        winner
    end
end