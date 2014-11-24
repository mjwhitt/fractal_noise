#!/usr/bin/env ruby

module FractalNoise
  VERSION    = '1.3.0'
  ALGORITHMS = ['value', 'perlin']
end

require 'chunky_png'

require_relative 'fractal_noise/interpolation'
require_relative 'fractal_noise/utils'
require_relative 'fractal_noise/filters'
require_relative 'fractal_noise/output'
require_relative 'fractal_noise/base'
require_relative 'fractal_noise/value_noise'
require_relative 'fractal_noise/perlin_noise'
