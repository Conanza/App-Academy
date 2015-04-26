require 'set'

class WordChainer
  attr_reader :current_words, :all_seen_words

  def initialize(dictionary_file)
    @dictionary = Set.new(File.readlines(dictionary_file).map(&:chomp))
  end



  def run(source, target)
    @current_words, @all_seen_words = [source], { source => nil }

    until @current_words.empty? || @all_seen_words.include?(target)
      explore_current_words
    end

    build_path(target).drop(1).join(" > ")
  end
  
  private

    def adjacent_word?(word1, word2)
      return false if word1.length != word2.length || word1 == word2

      (word1.length).times do |i|
        w1, w2 = word1.dup, word2.dup
        w1[i], w2[i] = " ", " "
    
        return true if w1 == w2
      end

      false
    end

    # returns all words in the dictionary one letter different than word
    def adjacent_words(word)
      @dictionary.select { |dict_word| adjacent_word?(word, dict_word) }
    end

    def build_path(target)
      path = [target]

      path.unshift(@all_seen_words[path.first]) until path.first.nil?

      path
    end
    
    def explore_current_words
      new_current_words = []
      @current_words.each do |current_word|
        adjacent_words(current_word).each do |adj_word|
          next if @all_seen_words.include?(adj_word)

          new_current_words << adj_word
          @all_seen_words[adj_word] = current_word
        end
      end
      @current_words = new_current_words
      print_new_current_words(new_current_words)
    end

    def print_new_current_words(new_current_words)
      new_current_words.each do |word|
        puts "New word, #{word}, came from #{@all_seen_words[word]}"
      end
    end
end

if $PROGRAM_NAME == __FILE__
  new = WordChainer.new("./dictionary.txt")
  # puts "adjacent_word? tests___________________________________________"
  # p new.adjacent_word?("cat", "bat") == true
  # p new.adjacent_word?("cat", "cit") == true
  # p new.adjacent_word?("cat", "cats") == false
  # p new.adjacent_word?("cat", "act") == false
  # puts "adjacent_words tests___________________________________________"
  # p new.adjacent_words("cats")
  # p new.adjacent_words("cat")
  puts "run tests______________________________________________________"
  p new.run("orange", "dredge")
  p new.run("duck", "ruby")
end