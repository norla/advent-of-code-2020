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

input = File.readlines("d5.txt").map { |x| x.strip() }
seat_numbers = input.map { |x| decode(x) }.map { |(row, col)| row * 8 + col }
puts "Part 1 %s" % [seat_numbers.sort[-1]]

all_seats = (0..127).to_a.product((0..7).to_a)
taken_seats = input.map { |x| decode(x) }
candidate_seats = all_seats.difference(taken_seats)
row, col = candidate_seats.find { |row, col|
  seat_num = row * 8 + col
  seat_numbers.include?(seat_num - 1) && seat_numbers.include?(seat_num + 1)
}
puts "Part 2 %d" % [row * 8 + col]
