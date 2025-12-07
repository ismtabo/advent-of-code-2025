#!/usr/bin/env ruby

require "set"

Point=Data.define(:x, :y)
class Beam < Point
  def drop
    Beam.new(self.x, self.y+1)
  end
  def split
    [Beam.new(self.x-1, self.y), Beam.new(self.x+1, self.y)]
  end
end
map=STDIN.readlines
map_height=map.length
start=Beam.new(*map.map.each_with_index{|row, i| [row.chars.index("S"), i]}.select{|j, i| j != nil}.first)
beams=Set.new([start])
historical_beams=Set.new
splits=0
loop do
  new_beams=Set.new
  for beam in beams do
    $stderr.puts "Evaluating #{beam}"
    if beam.y >= map_height.pred
      next
    end
    falling_drop=beam.drop
    $stderr.puts "Falling drop #{beam}"
    if map[falling_drop.y][falling_drop.x] == "^"
      $stderr.puts "Split at #{falling_drop.y} #{falling_drop.x}"
      new_beams|=falling_drop.split
      splits+=1
    else
      new_beams<<falling_drop
    end
  end
  historical_beams|=beams
  beams=new_beams
  $stderr.puts "#{beams}"
  if beams.all?{|b| b.y >= map_height.pred}
    break
  end
end
$stderr.puts "#{beams}"
puts "#{splits}"