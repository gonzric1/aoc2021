data = File.read("input.txt").split("\n")
coords =[]
#select only where x1 == x2 or y1 == y2
strings = data.map {|string| string.sub(" -> ", ",") }
coords = strings.map {|string| string.split(',')}

def intersection_count vent_map
  count = 0
  vent_map.each do |array|
    if !array.nil?
      total = array.count { |e| e && e > 1 }
      count += total
    end
  end
  count
end


X1, Y1, X2, Y2 = 0, 1, 2, 3
part_1_coords = coords.select{ |e| e[X1] == e[X2] || e[Y1] == e[Y2]}

vent_map = Array.new
part_1_coords.each do |coord|
  xsort =  [coord[X1].to_i, coord[X2].to_i]
  ysort = [coord[Y1].to_i, coord[Y2].to_i]

  (xsort.min..xsort.max).each do |x|
    (ysort.min..ysort.max).each do |y|
      vent_map[x] ||= []
      vent_map[x][y] ||= 0
      vent_map[x][y] = vent_map[x][y] + 1
    end
  end
end
p "horizontal & vertical only: #{intersection_count(vent_map)}"

part_2_coords = coords.select{ |e| e[X1] != e[X2] && e[Y1] != e[Y2]}

part_2_coords.each do |coord|
  x_change = (coord[X1].to_f / coord[X2].to_f) > 1 ? -1 : 1
  y_change = (coord[Y1].to_f / coord[Y2].to_f) > 1 ? -1 : 1
  times = (coord[X1].to_i - coord[X2].to_i).abs + 1
  times.times do |n|
    x = coord[X1].to_i + (n * x_change)
    y = coord[Y1].to_i + (n * y_change)
    vent_map[x] ||= [] #if [x] nil then empty array
    vent_map[x][y] ||= 0 #if x,y nil then 0
    vent_map[x][y] += 1
    #puts "VentMap at #{x}, #{y} is #{vent_map[x][y]}" if vent_map[x][y] > 1
  end
end

p "Diagonals added: #{intersection_count(vent_map)}"


