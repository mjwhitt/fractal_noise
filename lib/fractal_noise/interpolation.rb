#!/usr/bin/env ruby

module FractalNoise::Interpolation

  def linear_interpolation(a, b, alpha)
    a * (1 - alpha) + b * alpha
  end

  def cosine_interpolation(a, b, alpha)
    alpha = (1.0 - Math.cos(alpha*Math::PI)) / 2.0
    a * (1 - alpha) + b * alpha 
  end

end
