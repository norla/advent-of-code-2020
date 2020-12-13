input = File.readlines("d10.txt").map { |l| l.to_i }
adapters = input + [input.max + 3]
# p adapters

def run(joltage, used, unused)
  if unused.size == 0
    return used
  end
  suitable = unused.filter { |u| joltage.between?(u - 3, u - 1) }.sort
  suitable.each { |s|
    diff = s - joltage
    res = run(s, used + [[s, diff]], unused - [s])
    if res
      return res
    end
  }
  # p unused
  return nil
end

# res = run(0, [], adapters)
# puts "Part 1", res.filter { |diff| diff[1] == 3 }.length, res.filter { |diff| diff[1] == 1 }.length

# part 2
require "set"
# input = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
# input = [1, 2, 3, 4, 5]
adapters = (input + [input.max + 3]).sort
p adapters
combos = Set[[0]]
adapters.each { |j|
  # puts "j %d, combos %s" % [j, combos]
  new_combos = []
  dead_combos = []
  combos.each { |c|
    # puts "combo %s %s %s" % [c, c[-2], c[-1]]
    new_combos << c[0..-2].append(j) if c.length > 1 and c[-2].between?(j - 3, j)
    new_combos << c[0..-3].append(j) if c.length > 2 and c[-3]&.between?(j - 3, j)
    dead_combos << c if c[-1] < j - 3
    c << j
  }
  # puts "new %s, dead %s" % [new_combos, dead_combos]
  new_combos.each { |c| combos << c }
  dead_combos.each { |c| combos.delete(c) }
  puts "finished %d %d" % [j, combos.length]
  # puts " - - - -"
}
p combos.length
