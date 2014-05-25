#!/usr/bin/ruby

require_relative 'lib/permutationator'
answer = Permutationator.new([215,275,335,355,420,580], 1505)
combinations = answer.combos
puts answer.evaluate(combinations)
