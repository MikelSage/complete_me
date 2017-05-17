
#define a new class called CompleteMe
  #define a method called insert that takes in a word as an argument
    #word gets passed in and inserted into the tree
  #define a method named count
    #count returns how many words in the trie
  #define a method called suggest that takes in a substring as an argument
    #it returns an array of possible suggestions of the substring
  #define a method called populate that takes in a variable that holds a file
    #takes words in the file and inserts it into the trie

require 'minitest/autorun'
require 'minitest/pride'
require './lib/completeme'
require 'pry'

class CompleteMeTest < Minitest::Test
  def test_inserting_word_creates_trie
    completion = CompleteMe.new
    completion.insert("hello")
    assert_instance_of Trie, completion.trie
    assert completion.trie
    assert completion.trie.root
  end

  def test_count_works_for_one_word
    completion = CompleteMe.new
    completion.insert("hey")
    assert_equal 1, completion.count
  end

  def test_count_works_for_five_words
    completion = CompleteMe.new
    completion.insert("burger")
    completion.insert("hotdog")
    completion.insert("sandwich")
    completion.insert("salad")
    completion.insert("pasta")
    assert_equal 5, completion.count
  end

  def test_can_populate_trie_with_file
    completion = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    completion.populate(dictionary)

    assert completion.trie
    assert_equal 235886, completion.count
    #check for word examples
  end

  def test_suggest_for_small_trie
    completion = CompleteMe.new
    test_array = ['cat', 'car']

    completion.insert('cat')
    completion.insert('car')

    assert_equal test_array, completion.suggest('ca')
  end

  def test_for_longer_branches
    completion = CompleteMe.new
    test_array = ['cat', 'catty', 'car', 'carry']

    completion.insert('cat')
    completion.insert('car')
    completion.insert('catty')
    completion.insert('carry')

    assert_equal test_array, completion.suggest('ca')
  end

  def test_suggest_returns_suggestions_for_piz
    completion = CompleteMe.new
    test_array = ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"]
    dictionary = File.read("/usr/share/dict/words")
    completion.populate(dictionary)

    assert_equal test_array, completion.suggest('piz')
  end

  # def test_select_returns_nil_for_invalid_selection
  #   completion = CompleteMe.new
  #   dictionary = File.read("/usr/share/dict/words")
  #   completion.populate(dictionary)
  #
  #   assert_nil completion.select('piz', 'books')
  #   assert_nil completion.select('piz', 'booze')
  #   assert_nil completion.select('piz', 'pizxcv')
  # end

  def test_select_weights_one_word_correctly
    completion = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    completion.populate(dictionary)
    last_node = completion.trie.root.end_of_substring('piz'.chars)

    assert_equal ({}), last_node.words

    completion.select('piz', 'pizza')
    assert_equal ({'pizza' => 1}), last_node.words
  end

  def test_select_weights_multiple_words_correctly
    completion = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    completion.populate(dictionary)
    last_node = completion.trie.root.end_of_substring('piz'.chars)
    expected = {'pizza' => 1, 'pize' => 1, 'pizzle' => 1}

    completion.select('piz', 'pizza')
    completion.select('piz', 'pize')
    completion.select('piz', 'pizzle')

    assert_equal expected, last_node.words
  end

  def test_can_select_suggestion_more_than_once
    completion = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    completion.populate(dictionary)
    last_node = completion.trie.root.end_of_substring('piz'.chars)
    expected = {'pizza' => 1, 'pize' => 2, 'pizzle' => 1}

    completion.select('piz', 'pizza')
    completion.select('piz', 'pize')
    completion.select('piz', 'pizzle')
    completion.select('piz', 'pize')

    assert_equal expected, last_node.words
  end

  def test_suggest_returns_weighted_array
    completion = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    completion.populate(dictionary)
    expected = ['pize', 'pizzle', 'pizza', 'pizzeria', 'pizzicato']

    completion.select('piz', 'pizza')
    completion.select('piz', 'pize')
    completion.select('piz', 'pizzle')
    completion.select('piz', 'pize')

    assert_equal expected, completion.suggest('piz')
  end
end
