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
      assert newBoard,
      "Did not create new object of class Gameboard."
    end

    it "runs create_gameboard" do
      assert newBoard.create_gameboard(8, 8, "."),
      "Did not run create_gameboard."
    end

    it "creates expected game board" do
      assert_equal [[".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."]], newBoard.create_gameboard(8, 8, "."),
      "Did not create expected game board."
    end

    it "runs print_gameboard" do
      assert gameboard.print_gameboard(
        [[".", ".", ".", ".", ".", ".", ".", "."], 
        [".", ".", ".", ".", ".", ".", ".", "."], 
        [".", ".", ".", ".", ".", ".", ".", "."], 
        [".", ".", ".", ".", ".", ".", ".", "."], 
        [".", ".", ".", ".", ".", ".", ".", "."], 
        [".", ".", ".", ".", ".", ".", ".", "."], 
        [".", ".", ".", ".", ".", ".", ".", "."], 
        [".", ".", ".", ".", ".", ".", ".", "."]]), 
        "Did not run print_gameboard."
    end

  end

  # Tests for class Move:
  describe ConnectFour::Move do
    let(:newMove) {move.new}

    #it "creates new object of class "
  end

  # Tests for class WinnerDetection:
  describe ConnectFour::WinnerDetection do
    let(:newWinDet) {winnerDetection.new}

    $gameboard = 
      [[".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      ["x", ".", ".", ".", ".", ".", ".", "."], 
      [".", "x", ".", ".", ".", ".", ".", "."], 
      [".", ".", "x", "o", ".", "x", ".", "."], 
      [".", ".", "o", "x", ".", "x", ".", "."], 
      [".", "o", "x", "x", ".", "x", ".", "."], 
      ["o", "x", "x", "o", "x", "x", "x", "x"]]

    it "creates new object of class WinnerDetection" do
      assert newWinDet,
      "Did not create new object of class WinnerDetection"
    end

    it "runs detect_victory" do
      $x_or_o = "x"
      $col = 3
      assert newWinDet.detect_victory(7),
      "Did not run detect_victory."
    end

    it "detects winner vertically down" do
      $x_or_o = "x"
      $col = 5
      assert_equal 1, newWinDet.detect_victory(4),
      "Did not detect winner vertically down."
    end

    it "detects winner horizontally right and then left" do
      $x_or_o = "x"
      $col = 6
      assert_equal 1, newWinDet.detect_victory(7),
      "Did not detect winner horizontally right and then left."
    end

    it "detects winner horizontally right" do
      $x_or_o = "x"
      $col = 4
      assert_equal 1, newWinDet.detect_victory(7),
      "Did not detect winner horizontally right."
    end

    it "detects winner horizontally left" do
      $x_or_o = "x"
      $col = 7
      assert_equal 1, newWinDet.detect_victory(7),
      "Did not detect winner horizontally left."
    end

    it "detects winner diagonally down left and then up right" do
      $x_or_o = "o"
      $col = 1
      assert_equal 1, newWinDet.detect_victory(6),
      "Did not detect winner diagonally down left and then up right."
    end

    it "detects winner diagonally down left" do
      $x_or_o = "o"
      $col = 3
      assert_equal 1, newWinDet.detect_victory(4),
      "Dit not detect winner diagonally down left."
    end

    it "detects winner diagonally up right" do
      $x_or_o = "o"
      $col = 0
      assert_equal 1, newWinDet.detect_victory(7),
      "Did not detect winner diagonally up right."
    end

    it "detects winner diagonally down right and then up left" do
      $x_or_o = "x"
      $col = 2
      assert_equal 1, newWinDet.detect_victory(4),
      "Did not detect winner diagonally down right and then up left."
    end

    it "detects winner diagonally down right" do
      $x_or_o = "x"
      $col = 3
      assert_equal 1, newWinDet.detect_victory(5),
      "Did not detect winner diagonally down right."
    end

    it "detects winner diagonally up left" do
      $x_or_o = "x"
      $col = 0
      assert_equal 1, newWinDet.detect_victory(2),
      "Did not detect winner diagonally up left."
    end
  end

  # Tests for class Game:
  describe ConnectFour::Game do
    let(:newGame) {game.new}
  end
end 