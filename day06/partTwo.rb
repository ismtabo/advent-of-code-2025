#!/usr/bin/env ruby

Operation=Data.define(:op, :digits, :numbers)
input=STDIN.readlines
operations=input.slice(-1).split(/\s(?=[+*])/).map do |value|
    op=value[0]
    digits=value.count(" ") + 1
    Operation.new(op, digits, [])
end
input.slice(0, input.length - 1).map(&:chomp).each do |line|
    pointer=0
    operations.each do |op|
        op.numbers<<line[pointer...pointer+op.digits]
        pointer+=op.digits+1
    end
end
result=operations.reverse.sum do |op|
    numbers=op.numbers.map(&:chars).transpose.map(&:join).map(&:to_i).reverse
    case op.op
    when "+"
        numbers.sum
    else
        numbers.reduce{|a,b| a*b}
    end
end
puts result
