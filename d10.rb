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

# part
input = File.readlines("d10.txt").map { |l| l.to_i }
adapters = ([0] + input + [input.max + 3]).sort
paths = 1
processed = []
adapters.each { |j|
  processed.unshift(j)
  conseq_ones = processed.index.with_index {
    |n, i|
    (i == processed.length - 1) || (n - processed[i + 1] == 3)
  }
  if (conseq_ones.between?(2, 3)) then paths = paths * 2.0 end
  if (conseq_ones == 4) then paths = paths * 1.75 end
}
p paths.round
