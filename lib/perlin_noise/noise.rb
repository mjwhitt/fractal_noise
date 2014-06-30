#!/usr/bin/env ruby

class PerlinNoise::Noise
  attr_reader :white_noise, :perlin_noise, :octave_noise

  include PerlinNoise::Utils
  include PerlinNoise::Filters
  include PerlinNoise::Output

  def initialize(width, height, random=Random.new)
    @width, @height = width, height
    @white_noise    = array { random.rand }
    @perlin_noise   = array { 0.0 }
  end

  def generate(octaves=6, persistence=0.6)
    @perlin_noise = array { 0.0 } 
    @octave_noise = Array.new(octaves) { |octave| noise(octave) }

    amplitude = 1.0
    total     = 0.0

    (octaves - 1).downto(0) do |octave|
      amplitude *= persistence
      total     += amplitude

      xy { |x,y| @perlin_noise[x][y] += @octave_noise[octave][x][y] * amplitude }
    end

    xy { |x,y| @perlin_noise[x][y] /= total }

    return @perlin_noise
  end

  private

  def linear_interpolate(a, b, alpha)
    return a * (1 - alpha) + alpha * b
  end

  def cosine_interpolate(a, b, alpha)
    c = (1.0 - Math.cos(alpha*Math::PI)) * 0.5
    return  a * (1 - c) + c * b
  end

  def interpolate(a, b, alpha)
    return cosine_interpolate(a, b, alpha)
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

end
