data = File.read("input.txt").split
data.each { |s| s.split(" ")}
horizontal ||= 0
depth ||= 0
aim ||= 0

data.each_slice(2) do |direction, velocity|
  break if direction == 0

  p "direction: #{direction} velocity: #{velocity}"
  velocity = velocity.to_i
  case direction
    when "forward"
      horizontal += velocity
      depth += aim * velocity
    when "down"
      aim += velocity
    when "up"
      aim -= velocity
  end
end

p depth * horizontal