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


class String
  def capitalized?
    self == self.upcase
  end
end

def map_locations point = "start", explored = []
  paths = []
  explored << point unless point.capitalized?

  if point == "end"
    arry = [["end"]]
    return arry
  else
    unexplored = $locations[point] - explored
    return [[nil]] if unexplored.empty?
    unexplored.each do |node|
      map = map_locations(node, Array.new(explored))
      map.each do |path|
        path.unshift(point)
        paths << path
      end

    end
    paths.delete_if {|element| element.include? nil}
    return paths
  end
end

get_data
paths = map_locations
puts "Total Paths: #{paths.count}"
