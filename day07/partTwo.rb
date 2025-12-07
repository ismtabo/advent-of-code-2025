#!/usr/bin/env ruby

require "set"

Point=Data.define(:x, :y, :paths)
class Beam < Point
  def drop
    Beam.new(self.x, self.y+1, self.paths)
  end
  def split
    [Beam.new(self.x-1, self.y, self.paths), Beam.new(self.x+1, self.y, self.paths)]
  end
end
map=STDIN.readlines
map_height=map.length
start=Beam.new(*map.map.each_with_index{|row, i| [row.chars.index("S"), i, 1]}.select{|j, i| j != nil}.first)
beams=[start]
loop do
  new_beams=Array.new
  for beam in beams do
    $stderr.puts "Evaluating #{beam}"
    if beam.y >= map_height.pred
      next
    end
    falling_drop=beam.drop
    $stderr.puts "Falling drop #{beam}"
    if map[falling_drop.y][falling_drop.x] == "^"
      $stderr.puts "Split at #{falling_drop.y} #{falling_drop.x}"
      $stderr.puts "Splits to #{falling_drop.split}"
      new_beams+=falling_drop.split
    else
      $stderr.puts "Falls to #{falling_drop.y} #{falling_drop.x}"
      new_beams<<falling_drop
    end
  end
  $stderr.puts "New beams: #{new_beams}"
  grouped_beams=new_beams.group_by{|b| "#{b.x}/#{b.y}"}
  $stderr.puts "Grouped beams: #{grouped_beams}"
  beams=grouped_beams.values.map{|value| Beam.new(value.first.x, value.first.y, value.sum(&:paths))}
  $stderr.puts "Temporal beams: #{beams}"
  if beams.all?{|b| b.y >= map_height.pred}
    break
  end
end
$stderr.puts "Beams #{beams}"
puts "#{beams.sum(&:paths)}"