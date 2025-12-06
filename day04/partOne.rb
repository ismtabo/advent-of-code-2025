#!/usr/bin/env ruby

DIRECTIONS=[
  [-1, -1],
  [-1, 0],
  [-1, 1],
  [0, -1],
  [0, 1],
  [1, -1],
  [1, 0],
  [1, 1]
]

map=STDIN.readlines.map(&:chomp).map &:chars
STDERR.puts "#{map}"
result=map.flat_map.each_with_index do |row, y|
  row.map.each_with_index do |c, x|
    STDERR.puts "Evaluating (#{x}, #{y})=#{c}"
    if c == "."
      next Float::INFINITY
    end
    STDERR.puts "#{DIRECTIONS}"
    neighbors=DIRECTIONS.map do |dy, dx|
      STDERR.puts "Evaluating neighbor (#{dx}, #{dy})"
      ny=y+dy
      nx=x+dx
      if ny < 0 || ny >= map.length
        next nil
      end
      if nx < 0 || nx >= map[ny].length
        next nil
      end
      map[ny][nx]
    end.select {|n| n == "@"}.length
    STDERR.puts "#{neighbors}"
    neighbors
  end
end.select {|n| n < 4}.length
p result
