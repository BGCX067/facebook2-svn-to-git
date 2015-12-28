require File.dirname(__FILE__) + '/../test_helper'
require 'lifebookapi_controller'

class LifebookapiController; def rescue_action(e) raise e end; end

class LifebookapiControllerApiTest < Test::Unit::TestCase
  def setup
    @controller = LifebookapiController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_find_all_users
    result = invoke :find_all_users
    assert_equal nil, result
  end
end
