require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'

class NodeTest < Minitest::Test
  def test_has_no_children_by_default
    node = Node.new
    assert_equal ({}), node.children
  end

  def test_end_of_word_is_false_by_default
    node = Node.new
    assert_equal false, node.end_of_word
  end
end
