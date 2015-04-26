CONVERSIONS = { 
  0 => "0",
  1 => "1",
  2 => "2",
  3 => "3",
  4 => "4",
  5 => "5",
  6 => "6",
  7 => "7",
  8 => "8",
  9 => "9",
 10 => "A",
 11 => "B",
 12 => "C",
 13 => "D",
 14 => "E",
 15 => "F"
}

def num_to_s(num, base)
  new_num = ""
  
  power = 0
  while base ** power < num 
    value = base ** power
    unit = (num / value) % base

    new_num << CONVERSIONS[unit]
    power += 1
  end

  new_num.reverse
end

if $PROGRAM_NAME == __FILE__
  p num_to_s(5, 10) == "5"
  p num_to_s(5, 2)  == "101"
  p num_to_s(5, 16) == "5"

  p num_to_s(234, 10) == "234"
  p num_to_s(234, 2)  == "11101010"
  p num_to_s(234, 16) == "EA"
end