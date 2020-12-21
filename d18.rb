def scan(str, &evaluator)
  i = 0
  expr = ""
  until i == str.length
    if str[i] == "("
      matching_parens = matching_parens_index(str[i..str.length])
      expr << scan(str[i+1..(matching_parens + i - 1)], &evaluator)
      i = i + matching_parens
    else
      expr << str[i]
    end
    i += 1
  end
  evaluator.call(expr)
end

def matching_parens_index(str)
  balance = 0
  str.split("").each_with_index { |c, i|
    balance += 1 if c == "("
    balance -= 1 if c == ")"
    return i if (balance == 0)
  }
end

input = File.readlines("d18.txt").map { |l| l.gsub(" ", "").gsub("\n", "") }

part_1_eval = lambda { |expr|
  start = expr.scan(/\d+/)[0].to_i
  expr.scan(/\D\d+/).reduce(start) { |acc, e| eval("#{acc}#{e}") }.to_s
}
puts "Part 1: %d" % [input.map { |l| scan(l, &part_1_eval).to_i}.reduce(:+)]

part_2_eval = lambda { |expr|
  expr.split("*").map{|e| eval(e)}.reduce(:*).to_s
}
puts "Part 2: %d" % [input.map { |l| scan(l, &part_2_eval).to_i}.reduce(:+)]

puts scan("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2".gsub(" ", ""), &part_1_eval)
