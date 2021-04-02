class Player
  attr_reader :marker, :game
  def initialize(game, marker)
    @game = game
    @marker = marker
  end
end
