ONES = {
  0 => "zero",
  1 => "one",
  2 => "two",
  3 => "three",
  4 => "four",
  5 => "five",
  6 => "six",
  7 => "seven",
  8 => "eight",
  9 => "nine"
}

TENS = {
  20 => "twenty",
  30 => "thirty",
  40 => "forty",
  50 => "fifty",
  60 => "sixty",
  70 => "seventy",
  80 => "eighty",
  90 => "ninety"
}

TEENS = {
  10 => "ten",
  11 => "eleven",
  12 => "twelve",
  13 => "thirteen",
  14 => "fourteen",
  15 => "fifteen",
  16 => "sixteen",
  17 => "seventeen",
  18 => "eighteen",
  19 => "nineteen"
}

BIG_UNITS = {
  100 => "hundred",
  1000 => "thousand",
  1000000 => "million",
  1000000000 => "billion",
  1000000000000 => "trillion"
}

class Fixnum
  def in_words
    if self < 10
      ONES[self]
    elsif self < 20
      TEENS[self]
    elsif self < 100
      self.tens_in_words
    else
      magnitude = find_biggest_unit[0]

      amount = self / magnitude
      remainder = self % magnitude

      remainder.zero? ? "#{amount.in_words} #{BIG_UNITS[magnitude]}" :
        "#{amount.in_words} #{BIG_UNITS[magnitude]} #{remainder.in_words}"
    end
  end

  def find_biggest_unit
    BIG_UNITS.take_while { |unit, word| self / unit > 0}.last
  end

  def tens_in_words
    tens = self / 10
    remainder = self % 10
    remainder.zero? ? "#{TENS[tens * 10]}" : "#{TENS[tens * 10]} #{remainder.in_words}"
  end
end
