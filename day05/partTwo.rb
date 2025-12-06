#!/usr/bin/env ruby

ranges=Set.new
intervals_raw, _=STDIN.read.chomp.split("\n\n")
intervals_raw.lines.map do |l|
  start, _end=l.chomp.split("-")
  Range.new(start.to_i, _end.to_i)
end.each do |r|
  ranges<<r
end

loop do
  overlaping_ranges=ranges.select{|r| ranges.any?{|o| o != r && o.overlap?(r)}}
  if overlaping_ranges.empty?
    break
  end
  overlaping_ranges.each do |r|
    ranges.select {|o| o != r && o.overlap?(r)}.each do |o|
      ranges.delete(o)
      ranges<<Range.new([o.min, r.min].min, [o.max, r.max].max)
    end
  end
end

puts ranges.sum(&:size)
