require 'pry'

class Node
  attr_reader :data, :children
  attr_accessor :end_of_word, :words

  def initialize(data)
    @data = data
    @words = {}
    @children = {}
    @end_of_word = false
  end

  def insert(characters)
    char_to_check = characters.shift
    if @children.include?(char_to_check)
      @children[char_to_check].insert(characters)
    else
      @children[char_to_check] = Node.new(char_to_check)
      if characters.empty?
        @children[char_to_check].end_of_word = true
      else
        @children[char_to_check].insert(characters)
      end
    end
  end

  def has_children?
    !@children.empty?
  end

  def end_of_substring(characters)
    char_to_check = characters.shift
    if characters.empty?
      @children[char_to_check]
    elsif @children.include?(char_to_check)
      @children[char_to_check].end_of_substring(characters)
    end
  end
end
