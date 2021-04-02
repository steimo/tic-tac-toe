require "gosu"
require "hasu"
Hasu.load "board.rb"
Hasu.load "square.rb"
Hasu.load "player.rb"
Hasu.load "human_player.rb"

class Game < Hasu::Window
LINES = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  def initialize()
    super 840, 600
    self.caption = "Tic-tac-toe"
    @board = Board.new(self, Square) 
    @players = [HumanPlayer.new(self, "X"), HumanPlayer.new(self,"O")]
    @current_player_id = 0
  end

  def needs_cursor?
    false
  end

  def draw_board
    @board.draw
  end

  def button_down(id)
    if id == Gosu::MsLeft
      @board.winner = false
      place_player_marker(current_player)
      if player_has_won?(current_player)
        clear_board
        @board.winner = true
        @board.current_player = current_player.marker
      elsif board_full?
        @board.winner = true
        @board.current_player = "It's a draw!"
        clear_board
      end
      switch_players!
    end
  end

  def free_positions
    @board.squares.select {|square| square.mark.size < 1}
  end

  def board_full?
    free_positions.empty?
  end

  def place_player_marker(player)
      selection = @board.handle_mouse_down(self.mouse_x, self.mouse_y)
      return selection.mark = player.marker if free_positions.include?(selection)
  end

  def current_player
    @players[@current_player_id]
  end

  def switch_players!
    @current_player_id = other_player_id
  end

  def other_player_id
    1 - @current_player_id
  end

  def player_has_won?(player)
    LINES.any? do |line|
      line.all? {|position| @board.squares[position].mark == player.marker}
    end
  end

  def clear_board
    @board.squares.each {|square| square.mark = ""}
  end

  def draw
    self.update
    draw_board
  end
end
Game.run





