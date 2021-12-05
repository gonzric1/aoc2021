data = File.read("input.txt").split

gamma_rate ||= ""
epsilon_rate ||= ""
columns = [[],[],[],[],[],[],[],[],[],[],[],[]]
data.each do |row|
  i = 0
  row.each_char do |c|
    columns[i] << c.to_i
    i+=1
  end
end
columns.each do |column|
  bit = (column.sum(0.0) / column.size).round(0).to_i
  gamma_rate += (bit.to_s)
  epsilon_rate += bit == 0 ? "1" : "0"
end
puts "gamma rate: ", gamma_rate.to_i(2)
puts "inverse: ", epsilon_rate
puts "power consumption: ", gamma_rate.to_i(2) * epsilon_rate.to_i(2)


# part 2
#Check if gamma rate exists in array if true then done.
#Find most common digit (0...12) for i
# compare most common digit to row[i]
# add row[i] to matches if ==
# rerun with i+1 and matches.

def find_mcv_for_column data, i
  column = Array.new
  data.each do |row|
    column << row[i].to_i
  end
  return (column.sum(0.0) / column.size).round(0).to_i
end

def find_matches data, value, i
  matches = Array.new
  data.each do |row|
    if row[i].to_i == value
      matches << row
    end
  end
  return matches
end

def find_rating data, least = false

  (0...12).each do |i|
    mcv = find_mcv_for_column(data, i)
    mcv = (mcv-1).abs if least
    data = find_matches(data, mcv, i)
    return data[0].to_i(2) if data.count == 1
  end
end
oxygen_generator_rating=find_rating(data, false)
co2_scrubber_rating = find_rating(data, true)
p "MCV: #{oxygen_generator_rating}"
p "CO2 Scrubber Rating: #{co2_scrubber_rating}"
p "Life support rating: #{oxygen_generator_rating*co2_scrubber_rating}"