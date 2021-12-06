data = File.read("input.txt").split("\n")
numbers = data[0].split(",")
boards = Array.new

board = Hash.new
x = 0
(1...data.length).each do |i|
  y = 0
  if data[i] != "" #if not empty row
    data[i].split(" ").each do |char| #split that row into characters
      board[char.strip] = {called: false, x: x, y: y} #create hash from that caracter with coords
      y = (y+1) % 5 #increase Y coord for next character
    end
    x = (x + 1) % 5
  else
    boards << board
    board = Hash.new
  end
end
count = 0


bingo_board = nil
winners = []
# game loop
numbers.each do |n|
  break if winners.length == 99
  #break unless bingo_board.nil?
  puts "number called: #{n}"
  boards.each_with_index do |board, i|
    if board.member?(n)
      board[n][:called] = true
      puts "#{n} found on board #{i}"
      if (board.select{|key, value| value[:x] == board[n][:x] && value[:called]}).length == 5
        puts "HORIZONTAL BINGO ON BOARD: #{i}"
        winners |= [i]

        points = 0
        uncalled = board.select{ |key, value| !value[:called] }
        uncalled.keys.each do |number|
          points += number.to_i
        end
        puts "Uncalled sum: #{points}. Total Points: #{points * n.to_i}"
        break if winners.length == 99
        #bingo_board = i.to_s
        #break
      elsif (board.select{|key, value| value[:y] == board[n][:y] && value[:called]}).length == 5
      points = 0
        puts "VERTICAL BINGO ON BOARD:  #{i}"
        winners |= [i]

        bingo_board = i.to_s
        uncalled = board.select{|key, value| !value[:called]}
        uncalled.keys.each do |number|
          points += number.to_i
        end
        puts "Uncalled sum: #{points}. Total Points: #{points * n.to_i}"
        break if winners.length == 99
        #break
      end
    end
  end
end
puts "winners: #{winners}"
#boards.each do |board|
#  p "Board number: #{count}"
#  count += 1
#  p board
#  p "----------------"
#end
#score
# p numbers
class Board

end