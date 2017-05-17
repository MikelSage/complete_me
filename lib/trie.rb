require "./lib/node"
require "pry"
class Trie
  attr_reader :root
  def initialize
    @root = Node.new
  end

  def insert(word)
    current_node = @root
    word.each_char do |letter|
      if current_node.children.has_key?(letter)
        current_node = current_node.children[letter]
      else
        current_node.children[letter] = Node.new
        current_node = current_node.children[letter]
      end
      current_node.end_of_word = true if word[-1] == letter
    end
  end

end
