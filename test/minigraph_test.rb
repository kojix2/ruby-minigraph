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

  def test_if_minigraph_version_numbers_match
    begin
      out, err = capture_subprocess_io do
        pid = fork do
          MG.execute("--version")
        end
        Process.waitpid(pid)
      end
    rescue NotImplementedError
      # Windows does not support fork.
      skip "Fork not supported on this platform"
    end
    assert_match(/^[\d.\-r]+\n/, out)
    # The version number of the gem should match the version number of the
    # minigraph shared library. Prevent version mismatch before release.
    assert_includes Minigraph::VERSION, out.split("-r")[0]
    assert_equal "", err
  end
end
