point_sum = count_sum = 0
counts = Array.new(1000, 0)  # Predefined large array

ARGF.each_line do |line|
  card, win, have = line
    .chomp
    .match(/^Card\s*(\d+):\s+(.*?)\s+\|\s+(.*)\z/)&.captures

  unless card
    p "Line not matched: #{line}"
    next
  end

  card = card.to_i
  count = (counts[card] += 1)
  count_sum += count

  have_set = have.split.map(&:to_i).to_set
  num_winners = 0
  points = win.split.map(&:to_i).reduce(0) do |pts, num|
    if have_set.include?(num)
      num_winners += 1
      counts[card + num_winners] += count
      pts > 0 ? pts * 2 : 1
    else
      pts
    end
  end

  point_sum += points
end

puts "Point Sum: #{point_sum}", "Count sum: #{count_sum}"

