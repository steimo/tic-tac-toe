class Square 
  attr_reader :mark
  attr_writer :mark
  def initialize(window, column, row, mark)
    @window = window
    @font = Gosu::Font.new(112, {:bold => true, :italic => true})
    @row = row
    @column = column
    @mark = mark
    @color = Gosu::Color.argb(0xff_ffffff)
  end

  def draw
    x1 = 5 + @column * 280
    y1 = 5 + @row * 200
    x2 = x1 + 270
    y2 = y1
    x3 = x2
    y3 = y2 + 190
    x4 = x1
    y4 = y3
    c = @color
    @window.draw_quad(x1, y1, c, x2, y2, c, x3, y3, c, x4, y4, c, 0)
    x_center = x1 + 135
    y_center = y1 + 48
    x_text = x_center - @font.text_width("#{@mark}") / 2
    color_font = Gosu::Color.argb(0xff_ff0000)
    @font.draw_markup("#{@mark}", x_text, y_center, 0, scale_x = 1, scale_y = 1, color = color_font, mode = :default)
  end
end
