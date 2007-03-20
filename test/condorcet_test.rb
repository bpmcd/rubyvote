#!/usr/bin/ruby -Ilib

require 'test/unit'
require 'rubyvote/election'
require 'rubyvote/condorcet'

class TestCondorcetVote < Test::Unit::TestCase

  def test_condorcet
    vote_array = Array.new
    3.times {vote_array << "ABC".split("")}
    3.times {vote_array << "CBA".split("")}
    2.times {vote_array << "BAC".split("")}

    assert_equal ["B"], PureCondorcetVote.new(vote_array).result.winners[0]
  end

  def test_ssd
    vote_array = Array.new
    5.times {vote_array << "ACBED".split("")}
    5.times {vote_array << "ADECB".split("")}
    8.times {vote_array << "BEDAC".split("")}
    3.times {vote_array << "CABED".split("")}
    7.times {vote_array << "CAEBD".split("")}
    2.times {vote_array << "CBADE".split("")}
    7.times {vote_array << "DCEBA".split("")}
    8.times {vote_array << "EBADC".split("")}

    assert_equal "E", CloneproofSSDVote.new(vote_array).result.winners[0]
    assert_equal [['E'], ['A'], ['C'], ['B'], ['D']], 
                 CloneproofSSDVote.new(vote_array).result.get_full_results
  end

  def test_ssd2
    vote_array = Array.new
    5.times {vote_array << "ACBD".split("")}
    2.times {vote_array << "ACDB".split("")}
    3.times {vote_array << "ADCB".split("")}
    4.times {vote_array << "BACD".split("")}
    3.times {vote_array << "CBDA".split("")}
    3.times {vote_array << "CDBA".split("")}
    1.times {vote_array << "DACB".split("")}
    5.times {vote_array << "DBAC".split("")}
    4.times {vote_array << "DCBA".split("")}

    assert_equal "D", CloneproofSSDVote.new(vote_array).result.winners[0] 
    assert_equal [['D'], ['A'], ['C'], ['B']], 
                 CloneproofSSDVote.new(vote_array).result.get_full_results
  end

  def test_ssd3
    vote_array = Array.new
    3.times {vote_array << "ABCD".split("")}
    2.times {vote_array << "DABC".split("")}
    2.times {vote_array << "DBCA".split("")}
    2.times {vote_array << "CBDA".split("")}

    assert_equal "B", CloneproofSSDVote.new(vote_array).result.winners[0]
    assert_equal [['B'], ['C'], ['D'], ['A']], 
                 CloneproofSSDVote.new(vote_array).result.get_full_results
  end

  def test_ssd_incomplete_votes
    vote_array = Array.new
    3.times {vote_array << "ABCD".split("")}
    2.times {vote_array << "DABC".split("")}
    2.times {vote_array << "DBCA".split("")}
    4.times {vote_array << ["C"]}
    2.times {vote_array << "DBC".split("")}

    result = CloneproofSSDVote.new(vote_array).result
    assert_equal "B", result.winners[0]
    assert_equal [['B'], ['C'], ['D'], ['A']], result.get_full_results
  end

  def test_ssd_incomplete_votes_2
    vote_array = Array.new
    4.times {vote_array << ["C"]}
    3.times {vote_array << "ABCD".split("")}
    2.times {vote_array << "DABC".split("")}
    2.times {vote_array << "DBCA".split("")}
    2.times {vote_array << "DBC".split("")}

    result = CloneproofSSDVote.new(vote_array).result
    assert_equal "B", result.winners[0]
    assert_equal [['B'], ['C'], ['D'], ['A']], result.get_full_results
  end

  # 
  # At one point, we happened to be getting correct results due to the
  # happy accident that, for example, 'B'.each returns 'B'. The
  # following election with a single integer vote catches that
  # condition.
  #
  def test_ssd_single_vote
    result = CloneproofSSDVote.new([[78]]).result
    assert_equal 78, result.winners[0]
    assert_equal [[78]], result.get_full_results
  end

end