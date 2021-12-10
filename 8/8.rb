require 'pry'

data = File.read("input.txt").split("\n")
data.map! { |d| d.split(" | ")}
data.each {|e| e.map! { |d| d.split(" ").flatten}.flatten!}

def strings_to_array data
  data.map! do |array|
    array.map! {|string|string.chars.sort}
  end
  data
end

prepped_data = strings_to_array(data)
# length of "1" = 2, "7" = 3, "4" = 4, "8"=7
outputs = 0
prepped_data.each do |array|
  key = [[]]
  (0...10).each do |n| #can break this earlier if 1, 4, 7, 8 are found
    case array[n].length
      when 2
        key[1] = array[n]
      when 3
        key[7] = array[n]
      when 4
        key[4] = array[n]
      when 7
        key[8] = array[n]
    end
  end
  (0...10).each do |n|
    case array[n].length
      when 5
        if (key[7] - array[n]).empty?
          key[3] = array[n]
        elsif ((key[4] - key[1]) - array[n]).empty?
          key[5] = array[n]
        else
          key[2] = array[n]
        end
      when 6
        if (key[4] - array[n]).empty?
          key[9] = array[n]
        elsif (key[1]-array[n]).empty?
          key[0] = array[n]
        else
          key[6] = array[n]
        end
    end
  end
  code = ""
  (10..13).each do |n|
    array[n] = key.index(array[n]).to_s
    code += array[n]
  end
  outputs += code.to_i
end
p "total of outputs: #{outputs}"
