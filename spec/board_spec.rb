require 'rspec'
require_relative '../lib/board.rb'

RSpec.describe Board do
  let(:board) { Board.new }

  describe '#initialize' do
    it 'initializes with a board array' do
      expect(board.board).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
    end
  end

  describe '#update' do
    it 'updates the board with the given symbol at the given position' do
      board.update(0, 'X')
      expect(board.board[0]).to eq('X')
    end
  end

  describe '#full?' do
    context 'when the board is not full' do
      it 'returns false' do
        expect(board.full?).to eq(false)
      end
    end

    context 'when the board is full' do
      it 'returns true' do
        9.times { |i| board.update(i, 'X') }
        expect(board.full?).to eq(true)
      end
    end
  end

  describe '#check_winner' do
    context 'when there is a winner' do
      it 'returns true' do
        board.update(0, 'X')
        board.update(1, 'X')
        board.update(2, 'X')
        expect(board.check_winner).to eq(true)
      end
    end

    context 'when there is no winner' do
      it 'returns false' do
        board.update(0, 'X')
        board.update(1, 'O')
        board.update(2, 'X')
        expect(board.check_winner).to eq(false)
      end
    end
  end
end
