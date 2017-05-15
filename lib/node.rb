require 'pry'

class Node
  attr_reader :data, :children
  attr_accessor :end_of_word

  def initialize(data)
    @data = data
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

  # def count
  #   last_letters = 0
  #     @children.each do |key, child|
  #       # binding.pry
  #       if child.end_of_word
  #         last_letters += 1
  #         # child.count
  #       end
  #       child.count
  #     end
  #     last_letters
  # end
end
