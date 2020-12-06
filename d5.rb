def decode(seat)
  rows, cols = seat.unpack("a7a*")
  row = rows.chars.to_a.reduce({ from: 0, to: 127 }) { |acc, r|
    if (r == "F")
      { from: acc[:from], to: (acc[:to] + acc[:from]) / 2 }
    else
      { from: ((acc[:from] + acc[:to]) / 2.0).ceil, to: acc[:to] }
    end
  }[:from]
  col = cols.chars.to_a.reduce({ from: 0, to: 7 }) { |acc, r|
    if (r == "L")
      { from: acc[:from], to: (acc[:to] + acc[:from]) / 2 }
    else
      { from: ((acc[:from] + acc[:to]) / 2.0).ceil, to: acc[:to] }
    end
  }[:from]
  [row, col]
end

def seat_num(row, col) row * 8 + col end

input = File.readlines("d5.txt").map { |x| x.strip() }
seat_nums = input.map { |x| decode(x) }.map { |x| seat_num(*x) }
puts "Part 1 %s" % [seat_nums.sort[-1]]

all_seats = (0..127).to_a.product((0..7).to_a)
taken_seats = input.map { |x| decode(x) }
candidate_seats = all_seats.difference(taken_seats)
row, col = candidate_seats.find { |s|
  seat_nums.include?(seat_num(*s) - 1) && seat_nums.include?(seat_num(*s) + 1)
}
puts "Part 2 %d" % [row * 8 + col]
