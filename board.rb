class Board 
  attr_reader :squares
  attr_writer :winner, :current_player
  def initialize(window, square)
    @window = window
    @square = square
    @pointer_img = Gosu::Image.new('pointer.png')
    @squares = []
    (0..2).each do |row|
      (0..2).each do |column|
        @squares.push @square.new(@window, column, row, "")
      end
    end
    @winner
    @current_player 
  end

  def draw
    draw_squares
    draw_grid
    if @winner
      show_result(@current_player)
    end
  end

  def draw_squares
    x = @window.height
    y = @window.width
    size = y*2 
    mouse_x = @window.mouse_x
    mouse_y = @window.mouse_y
    color = Gosu::Color.argb(0xff_ffffff)
    @window.draw_quad(x-size, y-size, color, x+size, y-size, color, x-size, y+size, color, x+size, y+size, color, 0)
    @pointer_img.draw(mouse_x, mouse_y, 1, factor_x = 0.2, factor_y = 0.2)
    @squares.each do |square|
      square.draw
    end
    font = Gosu::Font.new(96, {:bold => true})
    color = Gosu::Color.argb(0xff_00ff00)

  end

  def draw_grid
    color = Gosu::Color.argb(0xff_808080)
    Gosu.draw_rect(280, 20, 2.5, 560, color, 0)
    Gosu.draw_rect(560, 20, 2.5, 560, color, 0)
    Gosu.draw_rect(20, 200, 800, 2, color, 0)
    Gosu.draw_rect(20, 400, 800, 2, color, 0)
  end

  def handle_mouse_down(x, y)
    row = (y.to_i)/200
    column = (x.to_i)/280
    @position_of_square = get_square(column, row)
  end

  def get_square(column, row)
    if column < 0 or column > 2 or row < 0 or row > 2
      return nil
    else
      return @squares[row * 3 + column]
    end
  end

  def show_result(current_player)
    if current_player != "X" && current_player != "O"
      message = "It's a draw!"
    else
      message = "#{current_player} wins!"
    end
    @window.draw_rect(0, 0, 840, 600,Gosu::Color.argb(0xf9_fffffff), 0)
    font = Gosu::Font.new(120, {:bold => true, :underline => true})
    color = Gosu::Color.argb(0xff_00ff00)
    center_x = 420 - font.text_width(message) / 2 
    font.draw_text(message, center_x, 250, 0, scale_x = 1, scale_y = 1, color, mode = :default)
  end

end






