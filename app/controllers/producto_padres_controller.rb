class ProductoPadresController < ApplicationController
  before_action :auth
  before_action :set_producto_padre, only: [:show, :edit, :update, :destroy]

  # GET /producto_padres
  # GET /producto_padres.json
  def index
    @producto_padres = ProductoPadre.all
  end

  # GET /producto_padres/1
  # GET /producto_padres/1.json
  def show
    @productos = Producto.where("producto_padre_id = ?",@producto_padre.id);
  end

  # GET /producto_padres/new
  def new
    @producto_padre = ProductoPadre.new
  end

  # GET /producto_padres/1/edit
  def edit
  end

  # POST /producto_padres
  # POST /producto_padres.json
  def create
    @producto_padre = ProductoPadre.new(producto_padre_params)

    respond_to do |format|
      if @producto_padre.save
        format.html { redirect_to producto_padres_path, notice: 'Producto padre creado.' }
        format.json { render :show, status: :created, location: @producto_padre }
      else
        format.html { render :new }
        format.json { render json: @producto_padre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /producto_padres/1
  # PATCH/PUT /producto_padres/1.json
  def update
    respond_to do |format|
      if @producto_padre.update(producto_padre_params)
        format.html { redirect_to @producto_padre, notice: 'Producto padre actualizado' }
        format.json { render :show, status: :ok, location: @producto_padre }
      else
        format.html { render :edit }
        format.json { render json: @producto_padre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /producto_padres/1
  # DELETE /producto_padres/1.json
  def destroy
    hijo = Producto.where("producto_padre_id = ?",@producto_padre.id);
    hijo.each do |x|
      x.destroy
    end
    @producto_padre.destroy
    respond_to do |format|
      format.html { redirect_to producto_padres_url, notice: 'Producto padre e hijos eliminados' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producto_padre
      @producto_padre = ProductoPadre.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producto_padre_params
      params.require(:producto_padre).permit(:nombre, :descripcion, :clave)
    end
end
