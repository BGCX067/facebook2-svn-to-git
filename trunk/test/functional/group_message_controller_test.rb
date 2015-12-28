require File.dirname(__FILE__) + '/../test_helper'
require 'group_message_controller'

# Re-raise errors caught by the controller.
class GroupMessageController; def rescue_action(e) raise e end; end

class GroupMessageControllerTest < Test::Unit::TestCase
  def setup
    @controller = GroupMessageController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
