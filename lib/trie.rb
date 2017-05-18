require_relative "node"

class Trie
  attr_reader :root
  def initialize
    @root = Node.new
  end

  def insert(word)
    current_node = @root
    word.each_char do |letter|
      if current_node.in_children?(letter)
        current_node = current_node.children[letter]
      else
        current_node.children[letter] = Node.new
        current_node = current_node.children[letter]
      end
    end
    current_node.end_of_word = true
  end

end
