require "./lib/node"
require "pry"
class Trie
  attr_reader :root
  def initialize
    @root = Node.new('root')
  end

  def insert(word)
    characters = word.chars
    @root.insert(characters)
  end

end
