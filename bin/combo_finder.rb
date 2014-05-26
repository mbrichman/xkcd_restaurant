#!/usr/bin/env ruby

require_relative '../lib/permutationator'
require_relative '../lib/parser'

raise ArgumentError.new "You must include a filename as an argument" if ARGV.size == 0
puts "\e[H\e[2J"
puts "Working..."
menu = Parser.new(ARGV[0])
target_price = menu.target
menu_hash = menu.item_hash

answer = Permutationator.new(menu_hash, target_price)
puts "\e[H\e[2J"
puts answer.solution
