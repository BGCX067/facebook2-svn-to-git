require File.dirname(__FILE__) + '/../test_helper'
require 'square_controller'

# Re-raise errors caught by the controller.
class SquareController; def rescue_action(e) raise e end; end

class SquareControllerTest < Test::Unit::TestCase
  def setup
    @controller = SquareController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
