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

    amplitude = 1.0
    max       = 0.0

    (octaves - 1).downto(0) do |octave|
      amplitude *= persistence
      max       += amplitude

      xy { |x,y| @fractal[x][y] += @octaves[octave][x][y] * amplitude }
    end

    xy { |x,y| @fractal[x][y] /= max }

    return @fractal
  end

end
