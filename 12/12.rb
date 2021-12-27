require 'pry'

locations = Hash.new
data = Array.new
def get_data
  $data = File.read("input.txt").split("\n")
  $data.map! { |d| d.split("-")}
  locations = $data.flatten.uniq.map! {|p| [p, []] }.to_h
  $data.each do |d|
      locations[d[0]] << d[1]
      locations[d[1]] << d[0]
  end
end

get_data
binding.pry