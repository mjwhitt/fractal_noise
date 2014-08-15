#!/usr/bin/env ruby

class FractalNoise::Base
  attr_reader :noise, :octave_noise

  include FractalNoise::Interpolation
  include FractalNoise::Utils
  include FractalNoise::Filters
  include FractalNoise::Output

  def initialize(width, height, random=Random.new)
    @width, @height = width, height
  end

  def generate(octaves=6, persistence=0.6)
    @noise        = array { 0.0 } 
    @octave_noise = Array.new(octaves) { |octave| noise(octave) }

    amplitude = 1.0
    max       = 0.0

    (octaves - 1).downto(0) do |octave|
      amplitude *= persistence
      max       += amplitude

      xy { |x,y| @noise[x][y] += @octave_noise[octave][x][y] * amplitude }
    end

    xy { |x,y| @noise[x][y] /= max }

    return @noise
  end

end