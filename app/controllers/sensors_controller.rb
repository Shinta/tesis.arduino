# encoding: utf-8
class SensorsController < ApplicationController
  before_filter :get_current_user, :except => :arduino_render
  before_filter :check_access, :except => :arduino_render
  protect_from_forgery :except => :arduino_render
  
  def update
    @sensor = Sensor.find(params[:id])
    if @sensor.update_attributes(params[:sensor])
      $REDIS.hset("sensors_pending", @sensor.arduino_code, @sensor.arduino_value)
    end
  end
  
  def change_value
    # sleep 2
    @sensor = Sensor.find(params[:id])
    @sensor.value = params[:value]
    @sensor.save
    $REDIS.hset("sensors_pending", @sensor.arduino_code, @sensor.value)
  end
  
  def arduino_render
    @sensor = Sensor.find(params[:id])
    render :change_value
  end
  
  protected
  def check_access
    unless @current_user
      flash[:alert] = "Acceso Denegado. Debe iniciar sesión."
      redirect_to :root
    end
  end

end
