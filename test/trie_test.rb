require 'minitest/autorun'
require "minitest/pride"
require "./lib/trie"
require "pry"

class TrieTest < Minitest::Test
  def test_root_nil_by_default
    trie = Trie.new

    assert_nil trie.root
  end

  def test_root_has_children_on_same_level
    trie = Trie.new

    trie.insert('bad')
    trie.insert('bat')

    assert trie.root.children
    assert_instance_of Node, trie.root.children['b'].children['a']
  end

  def test_root_can_have_multiple_branches
    trie = Trie.new
    test_child_keys = ['b', 'c', 'd']

    trie.insert('bad')
    trie.insert('cut')
    trie.insert('dog')

    # binding.pry

    assert_equal test_child_keys, trie.root.children.keys
  end

  def test_if_branch_can_have_multiple_ends
    trie = Trie.new

    trie.insert('go')
    trie.insert('gone')
    assert trie.root.children['g'].children['o'].end_of_word
    assert trie.root.children['g'].children['o'].children['n'].children['e'].end_of_word
  end
end
