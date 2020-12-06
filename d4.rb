input = File.readlines("d4.txt")
passports = input.reduce({ current: [], all: [] }) { |result, l|
  if (l.strip() == "")
    { current: [], all: result[:all] + [Hash[*(result[:current].flatten)]] }
  else
    { current: result[:current] + l.split(" ").map { |f| f.split(":") }, all: result[:all] }
  end
}[:all]

required = {
  "byr" => lambda { |x| !!(x =~ /^[0-9]{4}$/) && x.to_i.between?(1920, 2002) },
  "iyr" => lambda { |x| !!(x =~ /^[0-9]{4}$/) && x.to_i.between?(2010, 2020) },
  "eyr" => lambda { |x| !!(x =~ /^[0-9]{4}$/) && x.to_i.between?(2020, 2030) },
  "hgt" => lambda { |x|
    hgt, unit = x.match(/^([0-9]+)(cm|in)$/)&.captures
    hgt && (unit == "cm" ? hgt&.to_i.between?(150, 193) : hgt&.to_i.between?(59, 76))
  },
  "hcl" => lambda { |x| !!(x =~ /^#[0-9a-f]{6}$/) },
  "pid" => lambda { |x| !!(x =~ /^[0-9]{9}$/) },
  "ecl" => lambda { |x| !!(x =~ /^(amb|blu|brn|gry|grn|hzl|oth)$/) },
}

required_keys = required.keys.map { |k| k.to_s }
valid1 = passports.filter { |p| required_keys.difference(p.keys) == [] }
puts "Part 1: %d" % [valid1.length]

valid2 = valid1.filter { |p| p.keys.all? { |k| !required[k] || required[k].(p[k]) } }
puts "Part 2: %d" % [valid2.length]
