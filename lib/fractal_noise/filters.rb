#!/usr/bin/env ruby

module FractalNoise::Filters

  def normalize
    min, max = 1.0, 0.0

    xy do |x,y|
      value = @fractal[x][y]
      min   = value if value < min
      max   = value if value > max
    end

    xy { |x,y| @fractal[x][y] = (@fractal[x][y] - min)/(max - min)  }
  end

  def gamma_filter(gamma)
    xy { |x,y| @fractal[x][y] = @fractal[x][y] ** gamma  }
  end

  def median_filter(window)
    edgex = (window / 2).floor
    edgey = (window / 2).floor
    noise = array { 0 }

    xy { |x, y| noise[x][y] = @fractal[x][y] }

    xy do |x,y|
      values = []

      window.times do |fx|
        window.times do |fy|
          wx = x + fx - edgex
          wy = y + fy - edgey

          wx -= @width  if wx >= @width
          wy -= @height if wy >= @height

          values << @fractal[wx][wy]    
        end
      end

      values.sort!
      len = values.length
      new_value = len % 2 == 1 ? values[len/2] : (values[len/2 - 1] + values[len/2]).to_f / 2
      noise[x][y] = new_value
    end

    @fractal = noise
  end

  def range(min, max)
    xy { |x, y| @fractal[x][y] = ((@fractal[x][y] * (max - min)) / 1.0) + min }
  end

end
