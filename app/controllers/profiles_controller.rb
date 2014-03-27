# encoding: utf-8
class ProfilesController < ApplicationController
  before_filter :get_current_user
  before_filter :check_access
  add_breadcrumb "Inicio", :dashboard
  
  def index
    @profiles = Profile.all
    add_breadcrumb "Perfiles"
  end
  
  def new
    @profile = Profile.new
    add_breadcrumb "Perfiles", :profiles
    add_breadcrumb "Crear"
  end
  def create
    if request.post?
      @profile = Profile.new(params[:profile])
      if @profile.save
        flash[:notice] = "El perfil ha sido creado con éxito."
        redirect_to :profiles
      else
        add_breadcrumb "Perfiles", :profiles
        add_breadcrumb "Crear"
        render :action => :new
      end
    else
      redirect_to :new_profile
    end
  end
  
  def edit
    @profile = Profile.find(params[:id])
    add_breadcrumb "Perfiles", :profiles
    add_breadcrumb "Editar"
  end
  def update
    if request.put?
      @profile = Profile.find(params[:id])
      if @profile.update_attributes(params[:profile])
        flash[:notice] = "El perfil ha sido actualizado con éxito."
        redirect_to edit_profile_path(@profile)
      else
        add_breadcrumb "Perfiles", :profiles
        add_breadcrumb "Editar"
        render :edit
      end
    else
      redirect_to :new_profile
    end
  end
  
  def destroy
    if request.delete?
      @profile = Profile.find(params[:id])
      if @profile.users.count > 0
        flash[:alert] = "El perfil no puede ser eliminado por que existen usuarios asociados."
        redirect_to edit_profile_path(@profile)
      else
        if @profile.destroy
          flash[:notice] = "El perfil ha sido eliminado con éxito."
        end
        redirect_to :profiles
      end
    else
      redirect_to :profiles
    end
  end
  
  protected
  def check_access
    if @current_user
      if !@current_user.have_access?(:profiles, :manage)
        flash[:alert] = "Acceso Denegado. Su perfil no tiene permisos suficientes."
        redirect_to :dashboard
      end
    else
      flash[:alert] = "Acceso Denegado. Debe iniciar sesión."
      redirect_to :root
    end
  end

end
