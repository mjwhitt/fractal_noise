#!/usr/bin/env ruby

module PerlinNoise
  VERSION = '1.0.0'
end

require 'chunky_png'

require_relative 'perlin_noise/utils'
require_relative 'perlin_noise/filters'
require_relative 'perlin_noise/output'
require_relative 'perlin_noise/noise'
