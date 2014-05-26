#!/usr/bin/ruby
require 'bigdecimal'

class Permutationator

  attr_reader :combos, :solution

  def self.currency_to_number(string)
    (BigDecimal(string.scan(/(\d+[.]\d+)/).flatten.first) * 100).to_i
  end

  def initialize(hash, target)
    @target = target
    @menu_hash = hash
    @combinations = []
    ary = hash.keys
    permutations = no_permutations(ary, target)
    @combos = gather_combinations(ary, permutations ,target)
    @combos.flatten!(1)
    combinations = evaluate(@combos)
    show_solution(combinations)
  end

  def evaluate(combinations)
    combinations.size > 0 ? combinations.first : false
  end

  def show_solution(solution)
    if solution == false
      @solution = "Sorry! Looks like there are no combinations that match the provided price."
    else
      choices = solution.map {|s| @menu_hash[s]}.join(', ')
      @solution =  "Yay! You should order the following: #{choices} to equal $#{sprintf( "%0.02f", @target.to_f / 100)}"
    end
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
