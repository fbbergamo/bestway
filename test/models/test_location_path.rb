require "minitest/autorun"

class TestLocationPath < Minitest::Test
  def setup
    @path = LocationPath.new("A", "B", 2)
  end

  def test_that_kitty_can_eat
    assert_equal "OHAI!", @meme.i_can_has_cheezburger?
  end

  def test_that_it_will_not_blend
    refute_match /^no/i, @meme.will_it_blend?
  end

  def test_that_will_be_skipped
    skip "test this later"
  end
end
