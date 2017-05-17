require 'pry'

class Node
  attr_reader :children
  attr_accessor :end_of_word, :words

  def initialize
    @words       = {}
    @children    = {}
    @end_of_word = false
  end

  def has_children?
    !@children.empty?
  end

  def in_children?(character)
    @children.has_key?(character)
  end

  def was_selected?(string)
    @words.has_key?(string)
  end
end
