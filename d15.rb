#!/usr/bin/env ruby

def play(numbers, steps)
  spoken = Hash[numbers.map.with_index { |n, i| [n, { index: i + 1 }] }]
  prev_num = numbers[-1]
  for step in (numbers.size + 1)..steps
    result = spoken[prev_num]
    speak = result&.key?(:prev_index) ? result[:index] - result[:prev_index] : 0
    if spoken[speak]
      spoken[speak][:prev_index] = spoken[speak][:index]
      spoken[speak][:index] = step
    else
      spoken[speak] = { index: step }
    end
    prev_num = speak
  end
  prev_num
end

puts "Part 1 %d" % [play([2, 15, 0, 9, 1, 20], 2020)] # 1280
puts "Part 2 %d" % [play([2, 15, 0, 9, 1, 20], 30000000)]  # 651639
