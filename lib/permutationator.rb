#!/usr/bin/ruby
require 'bigdecimal'

class Permutationator

  attr_accessor :combos

  def self.currency_to_number(string)
    (BigDecimal(string.scan(/(\d+[.]\d+)/).flatten.first) * 100).to_i
  end

  def initialize(ary, target)
    @target = target
    @combinations = []
    permutations = no_permutations(ary, target)
    @combos = gather_combinations(ary, permutations ,target)
    @combos.flatten!(1)
  end

  def evaluate(combinations)
    combinations.size > 0 ? combinations.first : false
  end

  private

  def sum_values(ary)
    ary.inject(:+)
  end

  def gather_combinations(ary, size, target)
    raise TypeError "Input must be an array" unless ary.is_a?(Array)
    return @combinations if size == 0
    @combinations << ary.repeated_permutation(size).to_a.select {|a| sum_values(a) == target}
    gather_combinations(ary, size - 1, target)
  end

  def no_permutations(ary, target)
    prices = ary.sort {|a,b| a<=>b}
    target / prices[0]
  end

end
