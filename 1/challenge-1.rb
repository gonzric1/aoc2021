file_data = File.read("input.txt").split
file_data.map!(&:to_i)
depth_increased ||= 0
puts file_data[2000]
(0...file_data.length-3).each do |i|
  depth_increased += 1 if file_data[i] < file_data[i+3]
end

puts "steps increased: #{depth_increased}"


#Part Two
# Can we do a map to add together elements?