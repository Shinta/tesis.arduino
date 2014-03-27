# encoding: utf-8
class SensorGroupsController < ApplicationController
  before_filter :get_current_user
  before_filter :check_access
  add_breadcrumb "Inicio", :dashboard

  def show
    @sensor_group = SensorGroup.includes(:sensors).find(params[:id])
    @sensors = @sensor_group.sensors.active
    add_breadcrumb @sensor_group.name
  end
  
  protected
  def check_access
    unless @current_user
      flash[:alert] = "Acceso Denegado. Debe iniciar sesión."
      redirect_to :root
    end
  end

end
