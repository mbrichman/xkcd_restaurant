#!/usr/bin/ruby

class Permutationator

  attr_accessor :combos

  def initialize(ary, target)
    @target = target
    @combinations = []
    permutations = no_permutations(ary, target)
    @combos = gather_combinations(ary, permutations ,target)
    @combos.flatten!(1)
  end

  def evaluate(combinations)
    combinations.each do |c|
      if sum_values(c) == @target
        return "Yay! #{c} is what you're looking for!"
        break
      else
        return "Guess you're hungry! There is no valid combination"
      end
    end
  end

  private

    def sum_values(ary)
      ary.inject(:+)
    end

    def gather_combinations(ary, size, target)
      raise TypeError "Input must be an array" unless ary.is_a?(Array)
      return @combinations if size == 0
      @combinations << ary.repeated_permutation(size).to_a.reject {|a| sum_values(a) > target}
      gather_combinations(ary, size - 1, target)
    end

    def no_permutations(ary, target)
      prices = ary.sort {|a,b| a<=>b}
      target / prices[0]
    end

end
