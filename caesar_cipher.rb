def caesar_cipher(string, offset)
  string.gsub(/[a-z]/) do |char|
    pos = char.ord - "a".ord
    
    ((pos + offset) % 26 + "a".ord).chr
  end
end

if $PROGRAM_NAME == __FILE__
  p caesar_cipher("zany", 2) == "bcpa"
  p caesar_cipher("hello", 3) == "khoor"
end
