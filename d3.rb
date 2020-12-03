input = File.readlines("d3.txt").map{ |l| l.strip() } 

def run(grid, xD, yD) 
  trees = y = x = 0
  while y < grid.length
    trees += grid[y][x % grid[0].length ] == "#" ? 1 : 0;
    y += yD
    x += xD
  end
  return trees
end

puts "Part 1", run(input, 3,1)
puts "Part 2", [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].map{ |x| run(input, *x) }.inject(:*)
