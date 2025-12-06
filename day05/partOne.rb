#!/usr/bin/env ruby

intervals_raw, products_raw=STDIN.read.chomp.split("\n\n")
intervals=intervals_raw.lines.map do |l|
  start, _end=l.chomp.split("-")
  [start.to_i, _end.to_i]
end
result=products_raw.lines.map do |l|
  l.chomp.to_i
end.select do |n|
  intervals.any? {|start, _end| start <= n && n <= _end}
end.length
puts result
