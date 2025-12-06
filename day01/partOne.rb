#!/usr/bin/env ruby
number=50
times_pointing_0=0
STDIN.readlines.each do |line|
  match=/^([LR])(\d+)$/.match(line)
  turn=match[1]
  STDERR.puts "Turn: #{turn} Distance: #{match[2]} from #{number}"
  distance=match[2].to_i
  case
  when turn=="L"
    number-=distance
  when turn=="R"
    number+=distance
  end
  number%=100
  if number==0
    times_pointing_0+=1
  end
  STDERR.puts "Now pointing to #{number}, times pointing 0: #{times_pointing_0}"
end
puts times_pointing_0
