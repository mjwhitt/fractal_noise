#!/usr/bin/env ruby

module Noise::Utils

  def array
    Array.new(@width) { Array.new(@height) { yield } }
  end

  def xy
    @width.times { |x| @height.times { |y| yield(x,y) } }
  end

end
