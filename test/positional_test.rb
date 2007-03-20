#!/usr/bin/ruby -Ilib

require 'test/unit'
require 'rubyvote/election'
require 'rubyvote/positional'

class TestPositionalVote < Test::Unit::TestCase

  def test_borda
    vote_array = Array.new
    3.times {vote_array << "ABC".split("")}
    3.times {vote_array << "CBA".split("")}
    2.times {vote_array << "BAC".split("")}

    assert_equal( "B", BordaVote.new(vote_array).result.winners[0] )
  end
end
