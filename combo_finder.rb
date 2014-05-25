#!/Users/markrichman/.rbenv/shims/ruby

require_relative 'lib/permutationator'
require_relative 'lib/file_parser'

@menu_hash = {}
File.open(ARGV[0]).each_with_index do |line, i|
  if i == 0
  @target = Permutationator.currency_to_number(line)
  else
    menu_item = line.split(',')
    @price = Permutationator.currency_to_number(menu_item[1])
    @menu_hash[@price] = menu_item[0]
  end
end

answer = Permutationator.new(@menu_hash.keys, @target)
puts @target
combinations = answer.combos

solution = answer.evaluate(combinations)
if solution == false
  puts "Sorry! Looks like there are no combinations that match the provided price."
else
  choices = solution.map {|s| @menu_hash[s]}.join(', ')
  puts "Yay! You should order the following: #{choices} to equal $#{sprintf( "%0.02f", @target.to_f / 100)}"
end
