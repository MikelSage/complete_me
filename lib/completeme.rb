require "./lib/trie"
require "pry"

class CompleteMe
  attr_reader :trie, :count
  def initialize
    @trie  = Trie.new
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
    last_node   = find_last_node(substring)
    find_all_the_words(last_node, substring, suggestions)
    suggestions = order_suggestions_by_weight(suggestions, substring)
    suggestions
  end

  def find_all_the_words(node, substring, suggestions)
    suggestions << substring if node.end_of_word
    if node.has_children?
      node.children.keys.each do |letter|
        node_substring = substring
        node_substring += letter
        next_node = node.children[letter]
        find_all_the_words(next_node, node_substring, suggestions)
      end
    end
  end

  def select(substring, selection)
    last_node = find_last_node(substring)
    if last_node.was_selected?(selection)
      last_node.words[selection] += 1
    else
      last_node.words[selection] = 1
    end
  end

  def order_suggestions_by_weight(suggestions, substring)
    last_node = find_last_node(substring)
    return suggestions if last_node.words.empty?

    selected_words = sort_selected_words(last_node)
    selected_words.each {|word| suggestions.delete(word)}
    selected_words + suggestions
  end

  def sort_selected_words(node)
    node.words.keys.sort_by{|key| node.words[key]}.reverse
  end

  def find_last_node(string, current_node=@trie.root)
    string.each_char do |letter|
      if current_node.in_children?(letter)
        current_node = current_node.children[letter]
      else
        return nil
      end
      return current_node if letter == string[-1]
    end
  end

end
