def rps(choice)
  choices = %w(Rock Paper Scissors)
  computer_choice = choices.sample

  "Comp shows #{computer_choice}, #{rps_outcome(choice, computer_choice)}"
end

def rps_outcome(our_choice, computer_choice)
  game = [our_choice, computer_choice]
  winning_pairs = [["Rock", "Scissors"],
                   ["Scissors,", "Paper"],
                   ["Paper", "Rock"]]

  if winning_pairs.include?(game) then "Win!"
  elsif winning_pairs.include?(game.reverse) then "Lose"
  else "Draw"
  end 
end

def remix(drinks)
  alcohols, sodas = drinks.map(&:first), drinks.map(&:last)
  original_pairs = pair_drinks(alcohols, sodas)
  final_mix = []

  alcohols.each do |alcohol|
    other_soda = sodas.reject { |soda| original_pairs[alcohol] == soda }.sample

    final_mix << [alcohol, sodas.delete(other_soda)]
  end
  
  final_mix.last.last.nil? ? remix(drinks) : final_mix
end

def pair_drinks(alcohols, sodas)
  pairings = {}
  alcohols.each_with_index do |alcohol, i|
    pairings[alcohol] = sodas[i]
  end
  pairings
end

# 20.times { p rps("Rock") }

p remix([
  ["whiskey", "coke"],
  ["gin", "tonic"],
  ["vodka", "cranberry"]
])
