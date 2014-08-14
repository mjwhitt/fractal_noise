#!/usr/bin/env ruby

module Noise
  VERSION = '1.1.0'
end

require 'chunky_png'

require_relative 'noise/interpolation'
require_relative 'noise/utils'
require_relative 'noise/filters'
require_relative 'noise/output'
require_relative 'noise/base'
require_relative 'noise/value_noise'
require_relative 'noise/perlin_noise'
