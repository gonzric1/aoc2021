require 'pry'

$locations = Hash.new
$data = Array.new
def get_data 
  $data = File.read("input.txt").split("\n")
  $data.map! { |d| d.split("-")}
  $locations = $data.flatten.uniq.map! {|p| [p, []] }.to_h
  $data.each do |d|
      $locations[d[0]] << d[1]
      $locations[d[1]] << d[0]
  end
end
#If thre's a path forward, take it
# if there's no path foward, and not end - error
# if end, return end + point. 

class String
  def capitalized?
    self == self.upcase
  end
end
def map_locations point = "start", explored = []
  paths = []
  pp "current location: #{point}"
  if point == "end"
    ary = ["end"]
    return ary
  else
    explored << point unless point.capitalized?
    paths = []
    ($locations[point]-explored).each do |link|
      path =  map_locations(link, explored)
      pp path
     
    end
  end
  return paths
end

end
get_data
map_locations
binding.pry