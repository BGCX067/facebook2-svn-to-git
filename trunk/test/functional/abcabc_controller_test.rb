require File.dirname(__FILE__) + '/../test_helper'
require 'abcabc_controller'

# Re-raise errors caught by the controller.
class AbcabcController; def rescue_action(e) raise e end; end

class AbcabcControllerTest < Test::Unit::TestCase
  fixtures :abcabcs

  def setup
    @controller = AbcabcController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = abcabcs(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:abcabcs)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:abcabc)
    assert assigns(:abcabc).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:abcabc)
  end

  def test_create
    num_abcabcs = Abcabc.count

    post :create, :abcabc => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_abcabcs + 1, Abcabc.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:abcabc)
    assert assigns(:abcabc).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Abcabc.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Abcabc.find(@first_id)
    }
  end
end
