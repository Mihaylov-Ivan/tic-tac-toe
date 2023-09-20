require_relative '../lib/game.rb'
require 'stringio'

RSpec.describe Game do
  describe "#initialize" do
    subject(:game) { Game.new }

    it "initializes with the correct default attributes" do
      expect(game.instance_variable_get(:@player1)).to be_nil
      expect(game.instance_variable_get(:@player2)).to be_nil
      expect(game.instance_variable_get(:@board)).to be_a(Board)
      expect(game.instance_variable_get(:@current_player)).to be_nil
      expect(game.instance_variable_get(:@game_over)).to be(false)
    end
  end

  describe "#get_symbol" do
    subject(:game) { Game.new }

    before do
      allow(game).to receive(:player_symbol_prompt)
    end

    context "when a valid symbol is entered" do
      it "returns the symbol" do
        allow(game).to receive(:gets).and_return("X")
        expect(game.send(:get_symbol, "John", nil)).to eq("X")
        expect(game.get_symbol("John", "X")).to eq("X")
      end
    end

    context "when an invalid symbol is entered" do
      it "recurses until a valid symbol is entered" do
        allow(game).to receive(:gets).and_return("0", "9", "X")
        expect(game).to receive(:show_input_error).twice
        expect(game.send(:get_symbol, "John", nil)).to eq("X")
      end
    end
  end
end
