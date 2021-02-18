# frozen_string_literal: true

require 'test_helper'

MG = Minigraph

class MinigraphTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Minigraph::VERSION
  end
end
