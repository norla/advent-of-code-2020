regex = /(\d+)-(\d+) ([a-z]): ([a-z]+)/
pwds = File
  .readlines("d2.txt")
  .map{ |l| l.match(regex) {|m| {min: m[1].to_i, max: m[2].to_i, char: m[3], text: m[4.to_i]} } }

valid = pwds.select{ |text:, min:, max:, char:| text.count(char).between?(min, max) }
puts "Part 1", valid.length

valid2 = pwds.select{ |text:, min:, max:, char:| (text[min - 1] == char) ^ (text[max - 1] == char) }
puts "Part 2", valid2.length

