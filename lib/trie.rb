require "./lib/node"
require "pry"
class Trie
  attr_reader :root
  def initialize
    @root = nil
  end

  def insert(word)
    @root = Node.new('root') unless @root

    characters = word.chars
    @root.insert(characters)
  end

  # def count
  #   last_letters = 0
  #     @root.children.each do |key, child|
  #       if child.end_of_word
  #         last_letters += 1
  #         child.count
  #       end
  #       last_letters += child.count
  #     end
  #     last_letters
  # end

end
