#!/usr/bin/env ruby

input=STDIN.readlines
numbers=input.slice(0, input.length-1).map do |l|
    l.strip.split(/\s+/).map do |number|
        number.chomp.to_i
    end
end.transpose
operations=input.slice(-1).strip.split(/\s+/)
result=numbers.zip(operations).sum do |nn, op|
    case op
    when "+"
        nn.sum
    else
        nn.reduce {|a, b| a * b}
    end
end
puts result
