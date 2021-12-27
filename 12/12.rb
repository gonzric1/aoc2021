require 'pry'


def get_data
  $data = File.read("input.txt").split("\n")
  $data.map! { |d| d.split("-")}
end

get_data
points = $data.flatten.uniq
points.map! {|p| [p, []] }
locations=points.to_h

binding.pry