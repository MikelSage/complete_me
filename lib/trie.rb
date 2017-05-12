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

end
