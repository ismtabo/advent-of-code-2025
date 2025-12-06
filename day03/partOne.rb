#!/usr/bin/env ruby

require "json"

result=STDIN.read.chomp.split("\n").sum do |line|
  numbers=line.chomp.chars.map(&:to_i)
  max_idx=numbers[..-2].each_index.max_by {|i| numbers[i]}
  latest_numbers=numbers[max_idx+1..]
  min_idx=latest_numbers.each_index.max_by {|i| latest_numbers[i]}
  numbers[max_idx]*10+numbers[min_idx+max_idx+1]
end
puts result
