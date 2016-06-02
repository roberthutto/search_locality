require 'minitest/autorun'
require '../src/string_proximity_phrase'

class TestString < Minitest::Test


  #### POSITIVE CASES

  ##
  # Test string has 'term1' and 'term2' within distance 3 ignoring case.
  def test_term1_term2_within_3
    assert_equal(true, 'Term1 one two Term2'.proximity?('term1', 'term2', 3))
  end

  ##
  # Test string has 'term1' and 'term2' within default distance Infinity.
  def test_term1_term2_within_Infinity
    assert_equal(true, 'Term1 one two three four Term2'.proximity?('term1', 'term2'))
  end

  ##
  # Test string has 'term1' and 'term2' within distance 3 where terms are in reverse order.
  def test_term1_term2_within_3_terms_in_reverse
    assert_equal(true, 'Term2 one two Term1'.proximity?('term1', 'term2', 3))
  end

  ##
  # Test string has 'term1' and 'term2' within distance 3 intermediate words contain punctuation.
  def test_term1_term2_within_3_and_words_punctuation
    assert_equal(true, 'Term1 one tw\'o Term2'.proximity?('term1', 'term2', 3))
  end

  ##
  # Test string has 'term1' and 'term2' within distance 3 across \n boundary.
  def test_term1_term2_within_3_across_newline
    assert_equal(true, "Term1 one\ntwo Term2".proximity?('term1', 'term2', 3))
  end

  ##
  # Test string has 'term1' and 'term2' within distance 3 across "." boundary.
  def test_term1_term2_within_3_across_period
    assert_equal(true, 'Term1 one. two Term2'.proximity?('term1', 'term2', 3))
  end

  ##
  # Test string has 'term1' and 'term2' within distance 3 across ".\n" boundary.
  def test_term1_term2_within_3_across_period_newline
    assert_equal(true, "Term1 one.\ntwo Term2".proximity?('term1', 'term2', 3))
  end

  ##
  # Test string has 'term1' and 'term2' within distance 3 and ".\n" after term1.
  def test_term1_term2_within_3_across_period_newline_after_term1
    assert_equal(true, "Term1.?\none two Term2".proximity?('term1', 'term2', 3))
  end

  ##
  # Test string has 'term1' and 'term2' within distance 3 and "\n" after term1.
  def test_term1_term2_within_3_across_newline_after_term1
    assert_equal(true, "Term1\none two Term2".proximity?('term1', 'term2', 3))
  end

  ##
  # Test string has 'phrase 1' and 'phrase 2' within distance 3.
  def test_phrase1_phrase2_within_3
    assert_equal(true, 'Phrase 1 one two Phrase 2'.proximity?('phrase 1', 'phrase 2', 3))
  end

  ##
  # Test string has 'phrase 1' and 'phrase 2' within distance 3 phrase in reverse order.
  def test_phrase1_phrase2_within_3_reverse
    assert_equal(true, 'Phrase 2 one two Phrase 1'.proximity?('phrase 1', 'phrase 2', 3))
  end

  ##
  # Test string has 'phrase 1' and 'phrase 2' within distance 3 with "\n"
  def test_phrase1_phrase2_within_3_with_newline
    assert_equal(true, "Phrase 1\n one\ntwo Phrase 2".proximity?('phrase 1', 'phrase 2', 3))
  end

  ##
  # Test string has 'dr. phrase 1' and 'phrase 2' within distance 3 with punctuation in phrase1
  def test_phrase1_phrase2_within_3_with_punctuation_in_phrase1
    assert_equal(true, "Dr. Phrase 1 one\ntwo Phrase 2".proximity?('dr. phrase 1', 'phrase 2', 3))
  end


  #### NEGATIVE CASES

  ##
  # Test 'term1' and 'term2' are not within distance 3 ignoring case.
  def test_term1_term2__not_within_3
    assert_equal(false, 'Term1 one two three Term2'.proximity?('term1', 'term2', 3))
  end

  ##
  # Test does not contain first term
  def test_does_not_contain_first_term
    assert_equal(false, 'one two Term2'.proximity?('term1', 'term2', 100))
  end

  ##
  # Test does not contain second term
  def test_does_not_contain_second_term
    assert_equal(false, 'Term1 one two'.proximity?('term1', 'term2', 100))
  end

  ##
  # Test words that contain the term do not pass i.e. "Subterm1" contains "term1" but are not equivalent
  def test_term2_contained_word_doesnot_match
    assert_equal(false, 'Term1 one two Subterm1'.proximity?('term1', 'term2', 100))
  end
end