# encoding: utf-8
class UsersController < ApplicationController
  before_filter :get_current_user
  before_filter :check_access, :except => :index
  add_breadcrumb "Inicio", :dashboard
  
  def index
    @sensor_groups = SensorGroup.all
  end
  
  def list    
    @users = User.includes(:profile)
    add_breadcrumb "Usuarios"
  end
  
  def new
    @user = User.new
    add_breadcrumb "Usuarios", :users_list
    add_breadcrumb "Crear"
  end
  def create
    if request.post?
      @user = User.new(params[:user])
      if @user.save
        flash[:notice] = "El usuario ha sido creado con éxito."
        redirect_to :users_list
      else
        add_breadcrumb "Usuarios", :users_list
        add_breadcrumb "Crear"
        render :action => :new
      end
    else
      redirect_to :new_user
    end
  end
  
  def edit
    @user = User.find(params[:id])
    add_breadcrumb "Usuarios", :users_list
    add_breadcrumb "Editar"
  end
  def update
    if request.put?
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        flash[:notice] = "El usuario ha sido actualizado con éxito."
        redirect_to edit_user_path(@user)
      else
        add_breadcrumb "Usuarios", :users_list
        add_breadcrumb "Editar"
        render :edit
      end
    else
      redirect_to :new_user
    end
  end
  
  def destroy
    if request.delete?
      @user = User.find(params[:id])
      if @user.destroy
        flash[:notice] = "El usuario ha sido eliminado con éxito."
      end
    end
    redirect_to :users_list
  end
  
  protected
  def check_access
    if @current_user
      if !@current_user.have_access?(:users, :manage)
        flash[:alert] = "Acceso Denegado. Su perfil no tiene permisos suficientes."
        redirect_to :dashboard
      end
    else
      flash[:alert] = "Acceso Denegado. Debe iniciar sesión."
      redirect_to :root
    end
  end

end
