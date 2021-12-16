require 'pry'
data = File.read("input.txt").split("\n")


OPEN = ['[', '{', '<', '(']
CLOSED = [']', '}', '>', '(']
corrupted = Array.new
corrupted_indexes = []
autocomplete = []
data.each_with_index do |line, i|
  opened = Array.new
  line.chars.each do |char|

    if OPEN.include?(char)
      opened.push char
    else
      case opened.pop
      when '['
        if char != ']'
          corrupted << char
          data[i] = "CORRUPTED"
          opened = []
          break
        end

      when '{'
        if char != '}'
          corrupted << char
          data[i] = "CORRUPTED"
          opened = []
          break
        end
      when '<'
        if char != '>'
          corrupted << char
          data[i] = "CORRUPTED"
          opened = []
          break
        end
      when '('
        if char != ')'
          corrupted << char
          data[i] = "CORRUPTED"
          opened = []
          break
        end
      end
    end
  end
  autocomplete << opened if !opened.empty?
end

corrupted.map! do |x|
  if x == ')' then
    3
  elsif x==']' then 57
  elsif x=='}' then  1197
  else  25137
  end
end
puts "corrupted sum: #{corrupted.sum}"

data.delete_if { |x| x == "CORRUPTED" }

scores = []

autocomplete.each do |line|
  line.map! do |x|
    if x == '(' then
      1
    elsif x=='[' then 2
    elsif x=='{' then  3
    else  4
    end
  end
end

autocomplete_score = []

autocomplete.each do |x|
  score = 0
  x.reverse.each do |points|
    score *= 5
    score += points
  end
  autocomplete_score << score
end

autocomplete_score.sort!
p autocomplete_score[22]
