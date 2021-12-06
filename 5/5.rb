data = File.read("input.txt").split("\n")
coords =[]
#select only where x1 == x2 or y1 == y2
strings = data.map {|string| string.sub(" -> ", ",") }
coords = strings.map {|string| string.split(',')}

X1, Y1, X2, Y2 = 0, 1, 2, 3
part_1_coords = coords.select{ |e| e[X1] == e[X2] || e[Y1] == e[Y2]}

vent_map = Array.new
part_1_coords.each do |coords|
  xsort =  [coords[X1].to_i, coords[X2].to_i]
  ysort = [coords[Y1].to_i, coords[Y2].to_i]

  (xsort.min..xsort.max).each do |x|
    (ysort.min..ysort.max).each do |y|
      vent_map[x] ||= []
      vent_map[x][y] ||= 0
      vent_map[x][y] = vent_map[x][y] + 1
    end
  end
end
count = 0
vent_map.each_with_index do |array, i|
  if array.nil?
    p "empty at #{i}"
  else
    count += array.count { |e| e && e > 1}
  end
end

p vent_map.length
p data.length
p "count #{count}"