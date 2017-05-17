require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'

class NodeTest < Minitest::Test
  def test_has_no_children_by_default
    node = Node.new

    assert_equal ({}), node.children
    refute node.has_children?
  end

  def test_end_of_word_is_false_by_default
    node = Node.new

    assert_equal false, node.end_of_word
  end

  def test_no_words_selected_by_dafault
    node = Node.new

    assert_equal ({}), node.words
  end

  def test_knows_if_value_in_children
    node = Node.new
    node.children['h'] = Node.new

    assert node.in_children?('h')
    refute node.in_children?('s')
  end

  def test_knows_if_value_seleted
    node = Node.new
    node.words['pizza'] = 1

    assert node.was_selected?('pizza')
    refute node.was_selected?('pize')
  end
end
