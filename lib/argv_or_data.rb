module ARGVOrDATA
  def self.read
    if ARGV.empty? && $stdin.tty?
      DATA.read
    else
      ARGF.read
    end
  end
end

