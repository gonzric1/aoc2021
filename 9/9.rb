require 'pry'
$data = []
def get_data
  $data = File.read("input.txt").split("\n")
  $data.map! { |d| d.chars}
  $data = $data.map.with_index { |d, y|
    d.map.with_index do |_, x|
      args = {x: x, y: y, height: $data[y][x]}
      Location.new(args)
    end
  }
end

def find_low_points
  low_points = [] # "x, y" 0,0 is top left.

  $data.each do |y|
    y.each do |x|
      if x.low_point?
        low_points << x
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



def find_basin(point)
  basin = []
  if point.height < 9 && !point.mapped?
    basin << point
    point.mapped = true

    basin += find_basin(point.left) if point.left
    basin += find_basin(point.right) if point.right
    basin += find_basin(point.up) if point.up
    basin += find_basin(point.down) if point.down
  end
  basin
end


class Location
  attr_reader :x, :y, :height
  attr_accessor :mapped
  def initialize args
    @x = args[:x]
    @y = args[:y]
    @height = args[:height].to_i
    @mapped = false
  end
  def mapped?
    @mapped
  end
  def up
    if @y.zero?
      false
    else
      $data[@y - 1][@x]
    end
  end
  def down
    if @y == 99
      false
    else
      $data[@y + 1][@x]
    end
  end
  def left
    if @x.zero?
      false
    else
      $data[@y][@x - 1]
    end
  end
  def right
    if @x == 99
      false
    else
      $data[@y][@x+1]
    end
  end
  def low_point?
    if @height == 0 ||
       (right && @height < right.height &&
       left && @height < left.height &&
       up && @height < up.height &&
       down && @height < down.height)
       true
    else
      false
    end
  end
end

get_data
low_points = find_low_points
basins = Array.new
low_points.each do |point|
  basins << find_basin(point)
end
basins.sort_by!(&:length)
sum = basins.last(3)
p sum[0].length * sum[1].length * sum[2].length

#binding.pry