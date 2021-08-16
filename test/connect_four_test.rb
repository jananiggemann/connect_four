require "test_helper"

describe ConnectFour do
  subject { ConnectFour }
  let(:gameboard) {subject::Gameboard}
  let(:move) {subject::Move}
  let(:winnerDetection) {subject::WinnerDetection} 


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

    it "creates new object of class WinnerDetection" do
      assert newWinDet
    end


  end



end 

=begin
  
  



=begin  
 
end 
=begin
  it "runs detectVictory" do
    assert subject::WinnerDetection.new.detectVictory([[".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", "o", "."], 
      [".", ".", "o", "x", "x", "x", "x", "o"]], 7, 4, "x")
  end

end







  # Tests for class WinnerDetection:
=begin
  it "runs detectVictory" do
    assert subject::Move::NewWinnerDetection.detectVictory([[".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      [".", ".", ".", ".", ".", ".", ".", "."], 
      ["x", "x", "x", "x", ".", ".", ".", "."]], 7, 3, "x")
  end

  it "detects winner" do
    assert_equal "winner", subject::Move::NewWinnerDetection.detectVictory(
    [[".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    ["x", "x", "x", "x", ".", ".", ".", "."]], 7, 3, "x")

    assert_equal "winner", subject::Move::NewWinnerDetection.detectVictory(
    [[".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    ["x", "x", "x", "x", ".", ".", ".", "."]], 7, 0, "x")

    assert_equal "winner", subject::Move::NewWinnerDetection.detectVictory(
    [[".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", "x", ".", ".", ".", "."], 
    [".", ".", "x", "o", ".", ".", ".", "."], 
    [".", "x", "o", "x", ".", ".", ".", "."], 
    ["x", "o", "x", "o", "o", ".", ".", "."]], 5, 2, "x")

    assert_equal "winner", subject::Move::NewWinnerDetection.detectVictory(
    [[".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", "x", ".", ".", ".", "."], 
    [".", ".", ".", "o", "x", ".", ".", "."], 
    [".", ".", ".", "x", "o", "x", ".", "."], 
    [".", ".", ".", "o", "o", "o", "x", "."]], 5, 3, "x")

    assert_equal "winner", subject::Move::NewWinnerDetection.detectVictory(
    [[".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", ".", ".", ".", ".", "."], 
    [".", ".", ".", "x", ".", ".", ".", "."], 
    [".", ".", ".", "o", "x", ".", ".", "."], 
    [".", ".", ".", "x", "o", "x", ".", "."], 
    [".", ".", ".", "o", "o", "o", "x", "."]], 7, 6, "x")
  end

end
=end