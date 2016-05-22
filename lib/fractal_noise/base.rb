#!/usr/bin/env ruby

class FractalNoise::Base
  attr_reader :fractal, :octaves

  include FractalNoise::Interpolation
  include FractalNoise::Utils
  include FractalNoise::Filters
  include FractalNoise::Output

  def initialize(width, height, random=Random.new)
    @width, @height = width, height
  end

  def generate(octaves=6, persistence=0.6)
    @fractal = array { 0.0 } 
    @octaves = Array.new(octaves) { |octave| noise(octave) }

    amplitude = array { 1.0 }
    max       = array { 0.0 }

    (octaves - 1).downto(0) do |octave|
      xy do |x,y|
        amplitude[x][y] *= persistence.is_a?(Array) ? persistence[x][y] : persistence
        max[x][y]       += amplitude[x][y]
        @fractal[x][y]  += @octaves[octave][x][y] * amplitude[x][y]
      end
    end

    xy { |x,y| @fractal[x][y] /= max[x][y] }

    return @fractal
  end

end
