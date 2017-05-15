
#define a new class called CompleteMe
  #define a method called insert that takes in a word as an argument
    #word gets passed in and inserted into the tree
  #define a method named count
    #count returns how many words in the trie
  #define a method called suggest that takes in a substring as an argument
    #it returns an array of possible suggestions of the substring
  #define a method called populate that takes in a variable that holds a file
    #takes words in the file and inserts it into the trie
require "./lib/trie"
require "pry"

class CompleteMe
  attr_reader :trie, :count
  def initialize
    @trie = Trie.new
    @count = 0
  end

  def insert(word)
    # @trie = Trie.new unless @trie
    trie.insert(word)
    @count +=1
  end

  def suggest(substring)
    trie.suggest(substring)
  end

  def populate(dictionary)
    dictionary.split.each do |word|
      trie.insert(word)
      @count += 1
    end
  end
end
# binding.pry
