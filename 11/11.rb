require 'pry'


def get_data
  $data = File.read("input.txt").split("\n")
  $data.map! { |d| d.chars}
  $data = $data.map.with_index { |d, y|
    d.map.with_index do |_, x|
      args = {x: x, y: y, energy: $data[y][x].to_i}
      Octopus.new(args)
    end
  }
end

def tick
  reset_flashes
  increase_energy
  flash
  return true
end

def increase_energy
  $data.each do |array|
    array.each do |x|
       x.increase_energy
    end
  end
end

def flash
  $data.each do |array|
    array.each do |x|
       x.flash
    end
  end
end

def reset_flashes
  $data.each do |array|
    array.each do |octopus|
      octopus.flashed = false
    end
  end
end

class Octopus
  attr_accessor :flashed, :energy
  @@flashes = 0
  def initialize args
    @x = args[:x]
    @y = args[:y]
    @energy = args[:energy]
    @flashed = false
  end
  def self.flashes
    @@flashes
  end
  def increase_energy
    @energy += 1 if !@flashed
  end
  def flash
    if @energy > 9 && !@flashed
      @energy = 0
      @flashed = true
      @@flashes += 1
      neighbors.each do |point|
        $data[point[0]][point[1]].increase_energy
        $data[point[0]][point[1]].flash
      end
    end
  end

  def neighbors
    arr = [[@y-1, @x-1], [@y-1, @x], [@y-1, @x+1],
    [@y, @x-1], [@y, @x+1],
    [@y+1, @x-1], [@y+1, @x], [@y+1, @x+1]]

    if @y.zero?
      arr -= [[@y-1, @x-1], [@y-1, @x], [@y-1, @x+1]]
    end
    if @y == 9
      arr -= [[@y+1, @x-1], [@y+1, @x], [@y+1, @x+1]]
    end
    if @x.zero?
     arr -= [[@y-1, @x-1], [@y, @x-1], [@y+1, @x-1]]
    end
    if @x == 9
      arr -= [[@y-1, @x+1], [@y, @x+1], [@y+1, @x+1]]
    end
    return arr
  end
end

get_data
100.times do |x|
   tick
   puts "tick count: #{x}"
   puts "Total Flashes: #{Octopus.flashes}"
 end
puts Octopus.flashes
binding.pry