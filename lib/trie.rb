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

  # def suggest(substring)
  #   suggestions = []
  #   keys = ''
  #   last_node = @root.end_of_substring(substring.chars)
  #   # last_node.children.each do |key, child|
  #   #   if child.end_of_word
  #   #     suggestions << substring + key
  #   #   else
  #   #     child.children.each do |key, child|
  #   #
  #   #     end
  #   #   end
  #   # end
  #
  #   each_loop(last_node, suggestions, substring, keys)
  # end
  #
  # def each_loop(node, sug_array, substring, keys)
  #   node.children.each do |key, child|
  #     # binding.pry
  #     if child.end_of_word
  #       if child.children.empty?
  #         sug_array << substring + keys + key
  #       else
  #         sug_array << substring + keys + key
  #         keys << key
  #         each_loop(child, sug_array, substring, keys)
  #       end
  #     else
  #       keys << key
  #       # binding.pry
  #       each_loop(child, sug_array, substring, keys)
  #     end
  #     keys = reset_key(keys)
  #   end
  #   sug_array
  # end
end
