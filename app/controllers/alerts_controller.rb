# encoding: utf-8
class AlertsController < ApplicationController
  before_filter :get_current_user, :except => :arduino_render
  before_filter :check_access, :except => :arduino_render
  protect_from_forgery :except => :arduino_render
  add_breadcrumb "Inicio", :dashboard
  
  def index
    @alerts = Alert.order("created_at desc").limit(20)
    add_breadcrumb "Historial de Alertas"
  end
  
  def arduino_render
    @alert = Alert.find(params[:id])
  end
  
  def turn_off_main_alarm
    Alert.turn_off_main_alarm
    flash[:notice] = "<h4>Alarma Principal</h4>La <strong>Alarma Principal</strong> ha sido apagada con éxito."
    $REDIS.hset("sensors_pending", "alarma", 0)
    redirect_to :dashboard
  end
  
  protected
  def check_access
    unless @current_user
      flash[:alert] = "Acceso Denegado. Debe iniciar sesión."
      redirect_to :root
    end
  end
  
end
