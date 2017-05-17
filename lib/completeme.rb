
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
    trie.insert(word)
    @count +=1
  end

  def populate(dictionary)
    dictionary.split.each do |word|
      trie.insert(word)
      @count += 1
    end
  end

  def suggest(substring)
    suggestions = []
    node = @trie.root
    last_node = node.end_of_substring(substring.chars)
    find_all_the_words(last_node, substring, suggestions)
    suggestions = order_suggestions_by_weight(suggestions, substring)
    suggestions
  end

  def find_all_the_words(node, substring, suggestions)
    suggestions << substring if node.end_of_word
    if node.has_children?
      node.children.keys.each do |letter|
        node_prefix = substring
        node_prefix += letter
        child_node = node.children[letter]
        find_all_the_words(child_node, node_prefix, suggestions)
      end
    end
    suggestions
  end

  def select(substring, selection)
    node = @trie.root
    last_node = node.end_of_substring(substring.chars)

    if last_node.words.has_key?(selection)
      last_node.words[selection] += 1
    else
      last_node.words[selection] = 1
    end
  end

  def order_suggestions_by_weight(suggestions, substring)
    node = @trie.root
    last_node = node.end_of_substring(substring.chars)

    return suggestions if last_node.words.empty?

    selected_words = sort_selected_words(last_node)

    selected_words.each do |word|
      suggestions.delete(word)
    end

    selected_words + suggestions
  end

  def sort_selected_words(node)
    node.words.keys.sort_by{|val| node.words[val]}.reverse
  end

end
