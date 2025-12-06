#!/usr/bin/env ruby

require 'paint'

invalid_ids=[]
STDIN.read.chomp.split(",").each do |line|
  match=/^(\d+)-(\d+)$/.match(line)
  range_start=match[1].to_i
  range_end=match[2].to_i
  STDERR.puts "Processing range #{range_start}-#{range_end}"
  (range_start..range_end).each do |number|
    if number.to_s.chars.length % 2 != 0
      next
    end
    middle_index=number.to_s.chars.length / 2
    first_half=number.to_s.chars[0...middle_index]
    second_half=number.to_s.chars[middle_index..-1]
    if first_half == second_half
      STDERR.puts "Found invalid number: #{Paint[number, :red]}"
      invalid_ids << number
    end
  end
end
puts invalid_ids.sum
