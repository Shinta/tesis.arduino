#!/usr/bin/env ruby
# encoding: utf-8

# You might want to change this
ENV["RAILS_ENV"] ||= "develpment"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, "config", "environment")



$running = true

begin
  $arduino = Arduino.new
rescue Exception => e
  puts "[ERROR] #{e.message}"
  $running = false
end

Signal.trap("TERM") do
  $arduino.close
  $running = false
end

while($running) do
  redis_pending = $REDIS.hgetall('sensors_pending')
  unless redis_pending.empty?
    redis_pending.each do |code, value|
      $arduino.write("#{code}:#{value}.")
      puts "[DEBUG] SENT TO ARDUINO: #{code}:#{value}."
      $REDIS.hdel('sensors_pending', code)
      sleep 0.3
    end
  end
  arduino_return = $arduino.read
  if arduino_return
    puts "[DEBUG] RECEIVED FROM ARDUINO: #{arduino_return}"
    arduino_return = arduino_return.split(":")
    sensors = Sensor.where(:arduino_code => arduino_return[0])
    if sensors.empty?
      case arduino_return[0]
      when I18n.t('main_alarm.arduino_code')
        extra_params = "?"
        alert = Alert.new(:style => "main_alarm")
        case arduino_return[1]
        when "0"
          alert.style = "notice"
          alert.description = I18n.t('main_alarm.descriptions.turned_off')
          extra_params += "main_alarm_off=true"
          Alert.turn_off_main_alarm
          alert.save
          uri = URI.parse("http://#{I18n.t('config.server_host')}:#{I18n.t('config.server_port')}/alerts/#{alert.id}/arduino_render#{extra_params}")
          Net::HTTP.post_form(uri, initheader = {'Content-Type' =>'application/json'})
          alert.spam_notifications(:debug => true)
        when "1"
          alert.description = I18n.t('main_alarm.descriptions.fire')
          alert.save
          uri = URI.parse("http://#{I18n.t('config.server_host')}:#{I18n.t('config.server_port')}/alerts/#{alert.id}/arduino_render#{extra_params}")
          Net::HTTP.post_form(uri, initheader = {'Content-Type' =>'application/json'})
          alert.spam_notifications(:debug => true)
        when "2"
          alert.description = I18n.t('main_alarm.descriptions.intrusion')
          alert.save
          uri = URI.parse("http://#{I18n.t('config.server_host')}:#{I18n.t('config.server_port')}/alerts/#{alert.id}/arduino_render#{extra_params}")
          Net::HTTP.post_form(uri, initheader = {'Content-Type' =>'application/json'})
          alert.spam_notifications(:debug => true)
        when "3"
          alert.description = I18n.t('main_alarm.descriptions.temperature', :value => arduino_return[2])
          alert.save
          uri = URI.parse("http://#{I18n.t('config.server_host')}:#{I18n.t('config.server_port')}/alerts/#{alert.id}/arduino_render#{extra_params}")
          Net::HTTP.post_form(uri, initheader = {'Content-Type' =>'application/json'})
          alert.spam_notifications(:debug => true)
        when "4"
          alert.style = "warning"
          alert.description = I18n.t('main_alarm.descriptions.children_room_movement')
          alert.save
          uri = URI.parse("http://#{I18n.t('config.server_host')}:#{I18n.t('config.server_port')}/alerts/#{alert.id}/arduino_render#{extra_params}")
          Net::HTTP.post_form(uri, initheader = {'Content-Type' =>'application/json'})
        end
      when "iniciado"
        send_on_start_sensors = Sensor.send_on_start
        unless send_on_start_sensors.empty?
          for sensor in send_on_start_sensors
            $arduino.write("#{sensor.arduino_code}:#{sensor.value}.")
            puts "[DEBUG] SENT TO ARDUINO: #{sensor.arduino_code}:#{sensor.value}."
            sleep 0.3
          end
        end
      else
        puts "[WARNING] SENSOR NOT FOUND IN DB: #{arduino_return[0]}"
      end
    else
      for sensor in sensors
        if sensor.edit_by_arduino?
          sensor.value = arduino_return[1]
          sensor.arduino_value = arduino_return[2] unless arduino_return[2].blank?
          sensor.save
          uri = URI.parse("http://#{I18n.t('config.server_host')}:#{I18n.t('config.server_port')}/sensors/#{sensor.id}/arduino_render")
          Net::HTTP.post_form(uri, initheader = {'Content-Type' =>'application/json'})
        end
      end
    end
  end
end
