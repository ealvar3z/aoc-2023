require_relative 'lib/utils'

# Sample input for part_one
_input = <<~DATA
  Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
  Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
  Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
  Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
  Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
DATA

# Sample input for part_two
__input = <<~DATA
  Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
  Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
  Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
  Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
  Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
DATA

# Maximum cubes in the bag
max_cubes = { 'red' => 12, 'green' => 13, 'blue' => 14 }
def game_possible?(game_data, max_cubes)
  game_data.all? do |set|
    set.all? { |color, count| count <= max_cubes[color] }
  end
end

def part_one(input, max_cubes)
  total_id_sum = 0

  input.join("\n").each_line do |line|
    game_id, sets = line.split(':')
    game_id = game_id[/\d+/].to_i  # Extracting game ID number

    sets_data = sets.split(';').map do |set|
      set.scan(/(\d+) (red|green|blue)/).map { |count, color| [color, count.to_i] }.to_h
    end

    total_id_sum += game_id if game_possible?(sets_data, max_cubes)
  end
  total_id_sum
end

def part_two(input)
  total_power = 0

  input.join("\n").each_line do |line|
    sets_data = line.split(':').last.split(';').map do |set|
      set.scan(/(\d+) (red|green|blue)/).map { |count, color| [color, count.to_i] }.to_h
    end

    min_cubes = Hash.new(0)
    sets_data.each do |set|
      set.each { |color, count| min_cubes[color] = [min_cubes[color], count].max }
    end

    power = min_cubes.values.inject(:*) || 0
    total_power += power
  end
  total_power
end

file = Utils.read_input("input/day02.txt")

p "#{part_one(file, max_cubes)}"
p "#{part_two(file)}"
