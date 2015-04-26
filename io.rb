def guesser
  computer_number = rand(100) + 1
  guesses = 0
  loop do
    guesses += 1
    puts "Guess the number:"
    guess = Integer(gets)

    break if outcome(computer_number, guess) == computer_number
  end

  puts "Guessed in #{guesses} #{guesses > 1 ? "guesses" : "guess"}"
end

def outcome(computer_number, guess)
    case computer_number <=> guess
    when -1 then puts "Too high"
    when 1 then puts "Too low"
    when 0
      puts "You got it!"
      return guess
    end
end

# def fileshuffler
#   puts "What's the filename?"
#   filename = gets.chomp

#   File.open('output.txt', 'w') do |f|
#     f.puts(File.readlines(filename).shuffle)
#   end
# end

def shuffle_file(filename)
  base = File.basename(filename, ".*")
  extension = File.extname(filename)

  File.open("#{base}-shuffled#{extension}", "w") do |f|
    lines = File.readlines(filename)
    lines.shuffle.each { |line| f.puts(line) }
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.first
    shuffle_file(ARGV.first)
  else
    puts "ENTER FILENAME: "
    filename = gets.chomp
    shuffle_file(filename)
  end
end