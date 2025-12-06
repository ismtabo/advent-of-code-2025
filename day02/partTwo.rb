#!/usr/bin/env ruby

require 'paint'

invalid_ids=[]
STDIN.read.chomp.split(",").each do |line|
  match=/^(\d+)-(\d+)$/.match(line)
  range_start=match[1].to_i
  range_end=match[2].to_i
  STDERR.puts "Processing range #{range_start}-#{range_end}"
  (range_start..range_end).each do |number|
    string_number=number.to_s
    middle_index=string_number.chars.length / 2
    1.upto(middle_index) do |offset|
      if string_number.length % offset != 0
        next
      end
      substring=string_number.slice(0, offset)
      times_to_repeat=string_number.length / offset
      if /^(#{substring}){#{times_to_repeat}}$/.match(string_number)
        STDERR.puts "Found invalid number: #{Paint[number, :red]} (repeating '#{substring}' #{times_to_repeat} times)"
        invalid_ids << number
        break
      end
    end
  end
end
puts invalid_ids.sum
