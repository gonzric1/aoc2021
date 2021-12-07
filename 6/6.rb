data = File.read("input.txt").split(",")
fish = data.map(&:to_i)
fish_hash = Hash.new
#brute force
#80.times do |n|
#  puts "Day #{n}"
#  fish.map!{ |f| f == 0 ? 6 : f - 1}
#  babies = Array.new(fish.count(6), 8)
#  fish += babies
#end

#Hashes:
(0..8).each do |day|
  fish_hash[day] = fish.count(day) ? fish.count(day) : 0
end
p "fish hash init: #{fish_hash}"
def tick fish_hash
  new_fish_hash = Hash.new
  fish_hash.each_key do |key|
    if key == 0
      new_fish_hash[6] = fish_hash[0] + fish_hash[7]
      new_fish_hash[8] = fish_hash[0]
    elsif key == 7
    else
      new_fish_hash[key-1] = fish_hash[key]
    end
  end
  return new_fish_hash
end

256.times do |n|
  puts "Day #{n}"
  p fish_hash = tick(fish_hash)
end

count = 0
fish_hash.each_value do |value|
  count += value
end
puts "Total Fishes: #{count}"
