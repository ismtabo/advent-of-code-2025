#!/usr/bin/env ruby
number=50
times_pointing_0=0
STDIN.readlines.each do |line|
  match=/^([LR])(\d+)$/.match(line)
  turn=match[1]
  STDERR.puts "Turn: #{turn} Distance: #{match[2]} from #{number}"
  distance=match[2].to_i
  go_over_zero=false
  complete_cycles=distance / 100
  times_pointing_0+=complete_cycles
  distance%=100
  case
  when turn=="L"
    go_over_zero=number != 0 && number-distance<0
    number-=distance
  when turn=="R"
    go_over_zero=number != 0 && number+distance>100
    number+=distance
  end
  number%=100
  if go_over_zero || number==0
    times_pointing_0+=1
  end
  STDERR.puts "Now pointing to #{number}, times pointing 0: #{times_pointing_0}, go over zero: #{go_over_zero}"
end
puts times_pointing_0
