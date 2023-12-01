input = File
  .readlines("input/day01.txt")
  .map(&:strip)
  .reject(&:empty?)

def part_one(lines)
  lines.sum do |line|
    digits = line.scan(/\d/).flatten
    (digits.first + digits.last).to_i
  end
end

p "1: #{part_one(input)}"

DIGITS = %w(zero one two three four five six seven eight nine)
HASHED = DIGITS.zip( (0...(DIGITS.length)).to_a.map(&:to_s) ).to_h

def part_two(lines)
  lines.sum do |line|
    digits = line.scan(/(?=(\d|#{DIGITS.join('|')}))/).flatten

    first = HASHED[digits.first] || digits.first
    last = HASHED[digits.last] || digits.last

    (first + last).to_i
  end
end

p "2: #{part_two(input)}"
