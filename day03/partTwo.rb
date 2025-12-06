#!/usr/bin/env ruby

MAX_BATTERIES=12

result=STDIN.readlines[-1..].map do |line|
  numbers=line.chomp.chars.map(&:to_i)
  matrix = Array.new(numbers.length) { Array.new(numbers.length) { Array.new } }
  matrix[0][0]=[numbers[0]]
  (1...numbers.length).each do |i|
    matrix[i][0]=if matrix[i.pred][0].first > numbers[i]
      matrix[i.pred][0]
    else
      [numbers[i]]
    end
  end
  (1...numbers.length).each do |i|
    prev_numbers=matrix[0][i.pred]
    current_number=if prev_numbers.length < MAX_BATTERIES - 1
      prev_numbers + [numbers[i]]
    else
      prev_numbers[..-1] + [numbers[i]]
    end
    matrix[0][i]=if prev_numbers.join.to_i > current_number.join.to_i
      prev_numbers
    else
      current_number
    end
  end
  (2...numbers.length).each do |j|
    (j...numbers.length).each do |i|
      STDERR.puts "Cell (#{j}, #{i})"
      up_numbers=matrix[j][i.pred]
      current_number_up=if up_numbers.length < MAX_BATTERIES - 1
        up_numbers + [numbers[i]]
      else
        up_numbers[..-1] + [numbers[i]]
      end
      left_numbers=matrix[j.pred][i.pred]
      current_number_left=if left_numbers.length < MAX_BATTERIES - 1
        left_numbers + [numbers[i]]
      else
        left_numbers[..-1] + [numbers[i]]
      end
      matrix[j][i]=[up_numbers, left_numbers, current_number_up, current_number_left].max_by {|n| n.join.to_i}
    end
  end
  STDOUT.puts "#{matrix.map{|r| r.map{|c|c.join.rjust(numbers.length, " ")}.join(" ")}.join("\n")}"
  matrix[-1][-1].join.to_i
end
puts result
