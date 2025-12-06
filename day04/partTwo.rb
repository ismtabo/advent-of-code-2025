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
removed=0
loop do
  candidates=map.flat_map.each_with_index do |row, y|
    row.map.each_with_index do |c, x|
      STDERR.puts "Evaluating (#{x}, #{y})=#{c}"
      if c == "."
        next {:position=>[x, y], :neighbors => nil}
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
      {:position=>[x, y], :neighbors => neighbors}
    end
  end.select {|n| n[:neighbors] != nil && n[:neighbors] < 4}
  STDERR.puts "Candidates to remove: #{candidates}"
  if candidates.length == 0
    break
  end
  candidates.each do |candidate|
    x, y=candidate[:position]
    map[y][x]="."
  end
  removed+=candidates.length
end
p removed
