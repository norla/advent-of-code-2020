input = File.readlines("d10.txt").map { |l| l.to_i }
adapters = input + [input.max + 3]

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
  p unused
  return nil
end

# require 'pp'
res = run(0, [], adapters)
puts "Part 1", res.filter { |diff| diff[1] == 3 }.length, res.filter { |diff| diff[1] == 1 }.length
