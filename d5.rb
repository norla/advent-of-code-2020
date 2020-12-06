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
  row * 8 + col
end

input = File.readlines("d5.txt").map { |x| x.strip() }
puts "Part 1 %s" % [input.map { |x| decode(x) }.sort[-1]]
