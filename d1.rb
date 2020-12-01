numbers = File.readlines("d1-input.txt").map{ |s| s.to_i }

pair = numbers.permutation(2).find{ |p| p[0] + p[1] == 2020 }
puts "Part 1", pair[0] * pair[1]

triplet = numbers.permutation(3).find{ |t| t[0] + t[1] + t[2] == 2020 }
puts "Part 2", triplet[0] * triplet[1] * triplet[2]



