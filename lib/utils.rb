module Utils

  def self.read_input(file)
    File.readlines(file).map(&:chomp)
  end

  def self.get_input
    if ARGV.empty?
      input = DATA
    else
      file = ARGV.first
      File.read(file)
    rescue Errno::ENOENT
      p "#{file} not found"
      exit 1
    end
  end

  def self.to_ints(lines)
    lines.map(&:to_i)
  end

end
