# frozen_string_literal: true

require "test_helper"

MG = Minigraph

class MinigraphTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Minigraph::VERSION
  end

  def test_execute_with_string_arg
    assert_equal 0, MG.execute("--version")
    assert_equal 1, MG.execute("--lh 3")
    # After executing the "--version" command, the verbosity is changed to 3.
    # To prevent test_get_verbose from failing, set it back to 1.
    MG.verbose = 1
  end
end
