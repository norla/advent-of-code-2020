require "set"

groups = File
  .read("d6.txt")
  .split("\n\n")
  .map { |x| x.split("\n").map { |y| y.split("") } }

puts "Part 1: %d" % [groups.map { |x| Set.new(x.flatten).size }.inject(:+)]
puts "Part 2: %d" % [groups.map { |g| g.inject(:&).length }.inject(:+)]
