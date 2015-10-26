class AdminsController < ApplicationController
  before_action :autenticacion_admin!, only: [:destroy,:index,:new]
  before_action :auth
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /admins
  # GET /admins.json
  def index
    @users = User.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @user = User.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
      @user = User.new(user_params)
    unless @first_user.present?
      @user.privilegio = 2
    end
    if @user.save
      flash[:notice] = "Usuario Creado exitosamente." 
      unless @first_user.present?
        redirect_to root_path
      end
      unless @first_user.blank?
        redirect_to admins_path
      end
      
    else
      flash[:notice] = "Datos Erroneos o password menor a 8 caracteres"
      render :action => 'new'
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    user = User.find_by(id: params[:id])
    user.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Usuario destruido exitosamente' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find_by(id: params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :privilegio)
    end
end
