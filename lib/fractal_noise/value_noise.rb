#!/usr/bin/env ruby

class FractalNoise::ValueNoise < FractalNoise::Base

  def initialize(width, height, random=Random.new)
    super
    @white_noise = array { random.rand }
  end

  def noise(octave)
    noise     = array { nil }
    period    = 1 << octave
    frequency = 1.0 / period
   
    @width.times do |x|
      x1 = (x  / period) * period
      x2 = (x1 + period) % @width
      xb = (x  - x1)     * frequency

      @height.times do |y|
        y1 = (y  / period) * period
        y2 = (y1 + period) % @height
        yb = (y  - y1)     * frequency

        top    = interpolate(@white_noise[x1][y1], @white_noise[x2][y1], xb)
        bottom = interpolate(@white_noise[x1][y2], @white_noise[x2][y2], xb)

        noise[x][y] = interpolate(top, bottom, yb)
      end
    end

    return noise
  end

  private

  def interpolate(a, b, alpha)
    cosine_interpolation(a, b, alpha)
  end

end
