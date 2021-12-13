require 'pry'
$data = File.read("input.txt").split("\n")
$data.map! { |d| d.chars}

def find_low_points
  low_points = [] # "x, y" 0,0 is top left.

  $data.each_index do |y|
    $data[y].each_index do |x|
      if $data[y][x] == '0'
        low_points << [x,y]
      elsif lower_than_above?(x, y) &&
        lower_than_below?(x, y) &&
        lower_than_left?(x, y) &&
        lower_than_right?(x, y)
        low_points << [x, y]
      end
    end

  end
  low_points
end

def add_low_point_values (low_points)
  total = 0
  low_points.each do |array|
    value = $data[array[1]][array[0]].to_i
    total += value + 1
    p "total #{total}, #{value}"
  end
  puts "total #{total}"
end

def lower_than_above? (x, y)
  if y.zero?
    true
  else
    $data[y][x] < $data[y - 1][x]
  end
end

def lower_than_below? (x, y)
  if y == ($data.length - 1 )
    true
  else
    $data[y][x] < $data[y + 1][x]
  end
end

def lower_than_left? (x, y)
  if x.zero?
    true
  else
    $data[y][x] < $data[y][x-1]
  end
end

def lower_than_right? (x, y)
  if x == $data[0].length-1
    true
  else
    $data[y][x] < $data[y][x+1]
  end
end
# x, y
low_points = find_low_points

#Part Two - Use Lower than _ functions, keep going until 9
# Recursive, return [x,y] location of members of basin, add all of those to array, add array to basins array
# how to stop it from bouncing back and forth forever? Unmapped variable? This would be easier OO!
# Set mapped to true, add to array.
basins = []
#low_points.each do |point|
#  basins << find_basin(point)
#end
#
#def find_basin(point)
#  basin = []
#  #go left, add left point if left < left + left_of_left
#  return basin + find_basin(point)
#end

class Location
  attr_reader :x, :y, :height
  attr_accessor :mapped
  def initialize args
    @x = args[:x]
    @y = args[:y]
    @height = args[:height]
    @mapped = false
  end
end
binding.pry
