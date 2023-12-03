schematic = ARGF.readlines.map { |line| ".#{line.chomp}." }

schematic.push('.' * schematic[0].length)
schematic.unshift('.' * schematic[0].length)

part1 = 0
gears = Hash.new { |h, k| h[k] = [] }

(1..(schematic.size - 2)).each do |line|
  schematic[line].scan(/\d+/) do |num|
    x = $~.offset(0)[0] - 1 # Left edge

    found = false
    ((line - 1)..(line + 1)).each do |y|
      next if x < 0 || x + num.length + 2 > schematic[y].length # Check bounds
      str = schematic[y][x, num.length + 2]

      if str && str.match?(/[^\d.]/)
        found = true 
      end

      str.scan(/\*/) { gears[[y, x + $~.offset(0)[0]]] << num.to_i }
    end

    part1 += num.to_i if found
  end
end

part2 = gears.values.select { |v| v.size == 2 }.sum { |v| v.reduce(:*) }

puts "Part 1: #{part1}"
puts "Part 2: #{part2}"

