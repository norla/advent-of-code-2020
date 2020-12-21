#!/usr/bin/env ruby
# input = "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2".gsub(" ", "")
def scan(str)
  op = total = nil
  i = 0
  until i == str.length
    if str[i] =~ /[\+\*]/
      op = str[i]
      i = i + 1
    else
      num = if str[i] == "("
          expr = sub_expr(str[i..str.length])
          i = i + expr.length
          scan(expr[1..(expr.length - 2)])
        else
          i = i + 1
          str[i - 1].to_i
        end
      if (total == nil)
        total = num
      else
        # p total, num, op
        total = op == "+" ? (total + num) : (total * num)
      end
    end
  end
  puts "%s -> %d" % [str, total]
  total
end

def scan2(str)
  i = 0
  acc = ""
  until i == str.length
    if str[i] == "("
      expr = sub_expr(str[i..str.length])
      i = i + expr.length
      acc << scan2(expr[1..(expr.length - 2)])
    else
      acc << str[i]
      i += 1
    end
  end
  acc = acc.gsub(/(\d+)\+(\d+)/) { |m| m.split("+").map(&:to_i).reduce(:+) } while acc =~ /\+/
  acc = acc.gsub(/(\d+)\*(\d+)/) { |m| m.split("*").map(&:to_i).reduce(:*) } while acc =~ /\*/
  acc
end

def sub_expr(str)
  balance = 0
  ret = ""
  str.split("").find { |c|
    ret += c
    balance = balance + 1 if (c == "(")
    balance = balance - 1 if (c == ")")
    return ret if (balance == 0)
  }
end

input = File.readlines("d18.txt").map { |l| l.gsub(" ", "").gsub("\n", "") }
res = input.map { |l| scan(l) }.reduce(:+)
puts "Part 1: %d" % [res]

res = input.map { |l| scan2(l).to_i }.reduce(:+)
puts res
