require "set"

r = File
  .read("d6.txt")
  .split("\n\n")
  .map { |x| x.split("\n").map { |y| y.split("") }.flatten }
  .map { |x| Set.new(x).size }
  .inject(:+)
p r
