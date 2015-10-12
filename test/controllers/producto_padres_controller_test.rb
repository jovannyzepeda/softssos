require 'test_helper'

class ProductoPadresControllerTest < ActionController::TestCase
  setup do
    @producto_padre = producto_padres(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:producto_padres)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create producto_padre" do
    assert_difference('ProductoPadre.count') do
      post :create, producto_padre: { descripcion: @producto_padre.descripcion, nombre: @producto_padre.nombre }
    end

    assert_redirected_to producto_padre_path(assigns(:producto_padre))
  end

  test "should show producto_padre" do
    get :show, id: @producto_padre
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @producto_padre
    assert_response :success
  end

  test "should update producto_padre" do
    patch :update, id: @producto_padre, producto_padre: { descripcion: @producto_padre.descripcion, nombre: @producto_padre.nombre }
    assert_redirected_to producto_padre_path(assigns(:producto_padre))
  end

  test "should destroy producto_padre" do
    assert_difference('ProductoPadre.count', -1) do
      delete :destroy, id: @producto_padre
    end

    assert_redirected_to producto_padres_path
  end
end
