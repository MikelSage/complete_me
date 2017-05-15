
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
  def test_trie_nil_by_default
    completion = CompleteMe.new
    assert_nil completion.trie
  end

  def test_inserting_word_creates_trie
    completion = CompleteMe.new
    completion.insert("hello")
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

  # def test_can_populate_trie_with_file
  #   completion.CompleteMe.new
  #   dictionary = File.read("/usr/share/dict/words")
  #   completion.populate(dictionary)




end
