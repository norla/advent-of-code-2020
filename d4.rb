require 'pp'

current=[]
passports=[]

File.readlines("d4.txt").each{ |l|
  # puts l
  if (l.strip() == "")
    passports.push(Hash[*current.flatten])
    current = []
  else
    current += l.split(" ").map{ |f| f.split(":")}
  end
}
pp passports
required = {
  "byr": lambda{ |x| true},
            "iyr": , "eyr", "hgt", "hcl", "ecl", "pid" }
valid = passports.filter{ |p| required.difference(p.keys) == [] }
puts "Part 1 ", valid.length
