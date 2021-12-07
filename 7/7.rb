require 'pry'
data = File.read("input.txt").split(",")
data.map!(&:to_i)
data.sort!


def find_median data
  if data.length % 2 == 0
    avg = (data[(data.length/2 -1)] + data[data.length/2])/2
  else
    avg = data[data.legnth / 2]
  end
end

def fuel_cost n
  ((n**2) + n) / 2
end

def total_travel_distance data, location
  traveled = 0
  fuel = 0
  data.each do |d|
    distance = (location-d).abs
    traveled += distance
    fuel += fuel_cost(distance)
  end
  p "Distance traveled: #{traveled}"
  p "Fuel cost: #{fuel}"
end

median = find_median(data)
average = data.sum / data.size
p "Median:"
total_travel_distance(data, median)

p "Average"
total_travel_distance(data, average)
