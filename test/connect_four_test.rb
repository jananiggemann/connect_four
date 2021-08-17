require "test_helper"

describe ConnectFour do
  subject { ConnectFour }
  let(:gameboard) {subject::Gameboard}
  let(:move) {subject::Move}
  let(:winnerDetection) {subject::WinnerDetection} 
  let(:game) {subject::Game}

  # Tests for class Gameboard:
  describe ConnectFour::Gameboard do
    let(:newBoard) {gameboard.new}

    it "creates new object of class Gameboard" do
      assert newBoard
    end

    it "runs create_gameboard" do
      assert newBoard.create_gameboard(8, 8, ".")
    end

    it "creates expected game board" do
      assert_equal [[".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."]], newBoard.create_gameboard(8, 8, ".")
    end
  end

  # Tests for class Move:
  describe ConnectFour::Move do
    let(:newMove) {move.new}
  end

  # Tests for class WinnerDetection:
  describe ConnectFour::WinnerDetection do
    let(:newWinDet) {winnerDetection.new}

    $gameboard = [[".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      ["x", ".", ".", ".", ".", ".", ".", "."], 
      [".", "x", ".", ".", ".", ".", ".", "."], 
      [".", ".", "x", "o", ".", "x", ".", "."], 
      [".", ".", "o", "x", ".", "x", ".", "."], 
      [".", "o", "x", "x", ".", "x", ".", "."], 
      ["o", "x", "x", "o", "x", "x", "x", "x"]]

    it "creates new object of class WinnerDetection" do
      assert newWinDet
    end

    it "runs detectVictory" do
      $x_or_o = "x"
      $col = 3
      assert newWinDet.detectVictory(7)
    end

    it "detects winner vertically down" do
      $x_or_o = "x"
      $col = 5
      assert_equal 1, newWinDet.detectVictory(4)
    end

    it "detects winner horizontally right and then left" do
      $x_or_o = "x"
      $col = 6
      assert_equal 1, newWinDet.detectVictory(7)
    end

    it "detects winner horizontally right" do
      $x_or_o = "x"
      $col = 4
      assert_equal 1, newWinDet.detectVictory(7)
    end

    it "detects winner horizontally left" do
      $x_or_o = "x"
      $col = 7
      assert_equal 1, newWinDet.detectVictory(7)
    end

    it "detects winner diagonally down left and then up right" do
      $x_or_o = "o"
      $col = 1
      assert_equal 1, newWinDet.detectVictory(6)
    end

    it "detects winner diagonally down left" do
      $x_or_o = "o"
      $col = 3
      assert_equal 1, newWinDet.detectVictory(4)
    end

    it "detects winner diagonally up right" do
      $x_or_o = "o"
      $col = 0
      assert_equal 1, newWinDet.detectVictory(7)
    end

    it "detects winner diagonally down right and then up left" do
      $x_or_o = "x"
      $col = 2
      assert_equal 1, newWinDet.detectVictory(4)
    end

    it "detects winner diagonally down right" do
      $x_or_o = "x"
      $col = 3
      assert_equal 1, newWinDet.detectVictory(5)
    end

    it "detects winner diagonally up left" do
      $x_or_o = "x"
      $col = 0
      assert_equal 1, newWinDet.detectVictory(2)
    end
  end

  # Tests for class Game:
  describe ConnectFour::Game do
    let(:newGame) {game.new}
  end
end 