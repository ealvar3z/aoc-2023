require_relative 'lib/argv_or_data'

class MapEntry
  attr_accessor :src, :dest, :len

  def initialize(src, dest, len)
    @src = src
    @dest = dest
    @len = len
  end
end

def parse_map(group)
  name = group[0].split(' ')[0]
  entries = []

  group[1..].each do |line|
    entries << parse_entry(line)
  end

  [name, entries]
end

def parse_entry(line)
  parts = line.split.map(&:to_i)
  MapEntry.new(parts[1], parts[0], parts[2])
end

def parse_seeds(group)
  group[0].split(': ')[1].split.map(&:to_i)
end

def lookup(src, entries)
  entries.each do |entry|
    if src >= entry.src && src <= entry.src + entry.len
      return entry.dest + (src - entry.src)
    end
  end

  src
end

def seed_to_location(seed, maps)
  soil = lookup(seed, maps['seed-to-soil'])
  fertilizer = lookup(soil, maps['soil-to-fertilizer'])
  water = lookup(fertilizer, maps['fertilizer-to-water'])
  light = lookup(water, maps['water-to-light'])
  temp = lookup(light, maps['light-to-temperature'])
  humid = lookup(temp, maps['temperature-to-humidity'])
  location = lookup(humid, maps['humidity-to-location'])

  location
end

# main
lines = ARGVOrDATA.read.split("\n")

groups = []
current = []

lines.each_with_index do |line, i|
  if line.empty? || i == lines.length - 1
    groups << current
    current = []
    next
  end

  current << line
end

seeds = parse_seeds(groups[0])
maps = {}

(1...groups.length).each do |i|
  name, entries = parse_map(groups[i])
  maps[name] = entries
end

min_loc = Float::INFINITY
seeds.each do |seed|
  loc = seed_to_location(seed, maps)
  min_loc = loc if loc < min_loc
end

puts "Part 1: #{min_loc}"

# Part 2 has to be done in Crystal, as the algorithm is too slow in Ruby for the
# actual input. It is almost instant with the test input, though.


__END__
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
