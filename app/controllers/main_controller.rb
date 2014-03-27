# encoding: utf-8
class MainController < ApplicationController

  def index
    @user = User.new
    render :layout => "login"
  end
  
  def login
    if request.post?
      @user = User.find_by_username(params[:username])
      if @user.nil?
        flash[:alert] = "El usuario ingresado no existe."
        render :index, :layout => "login"
      else
        if @user.authenticate(params[:password])
          session[:user] = @user.id
          redirect_to :dashboard
        else
          flash[:alert] = "La contraseña ingresada es incorrecta."
          render :index, :layout => "login"
        end
      end
    else
      redirect_to :root
    end
  end
  
  def logout
    session[:user] = nil
    flash[:notice] = "La sesión ha finalizado con éxito."
    redirect_to :root
  end

end
