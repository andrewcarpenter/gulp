require 'test_helper'

class PhraseExtractorTest < Test::Unit::TestCase
  def setup
    @extractor = Gulp::PhraseExtractor.new
  end
  
  def phrases_for(text)
    word_count, phrases = @extractor.extract(text)
    phrases
  end
  
  should "chunk phrases combinatorially" do
    assert_equal(["y z"], phrases_for("y z"))
    assert_equal(["x y", "y z", "x y z"], phrases_for("x y z"))
    assert_equal(["w x", "x y", "y z", "w x y", "x y z", "w x y z"], phrases_for("w x y z"))
  end
  
  should "skip phrases starting with a stopword" do
    assert_equal([], phrases_for("the cow"))
    assert_equal(["cow jumped"], phrases_for("the cow jumped"))
  end
  
  should "skip phrases ending with a stopword" do
    assert_equal([], phrases_for("cow of"))
    assert_equal(["fancy cow"], phrases_for("fancy cow of"))
  end
  
  should "split phrases on punctuation" do
    punctuation_chars = %w(. , ; : |)
    punctuation_chars.each do |char|
      assert_equal ["w x", "y z"], phrases_for("w x#{char} y z")
    end
  end
  
  should "normalize whitespace" do
    assert_equal ["y z"], phrases_for("y   z   ")
    assert_equal ["y z"], phrases_for("    y   z")
    assert_equal ["y z"], phrases_for("    y   z   ")
  end
  
  should "remove parentheticals first" do
    assert_equal ["y z"], phrases_for("y (alpha beta) z")
  end
end
