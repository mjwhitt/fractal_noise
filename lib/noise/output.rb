#!/usr/bin/env ruby

module Noise::Output

  def output(filename)
    image = ChunkyPNG::Image.new(@width, @height)
    xy { |x,y| image[x,y] = yield(@noise[x][y]) }
    image.save(filename)
  end

  def output_xy(filename)
    image = ChunkyPNG::Image.new(@width, @height)
    xy { |x,y| image[x,y] = yield(x, y) }
    image.save(filename)
  end

  def grayscale(filename)
    output(filename) do |value|
      color = (value == 1.0 ? 255.0 : value * 256.0).floor
      ChunkyPNG::Color.rgb(color, color, color)
    end
  end

end
