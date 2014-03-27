class Sensor < ActiveRecord::Base
  belongs_to :sensor_group
  attr_accessible :name, :value, :sensor_group_id, :arduino_code, :ui_style, :arduino_value
  
  scope :active, where("active = 1").order("position")
  scope :send_on_start, where("send_on_start = 1")
  
  after_save :set_event
  before_save :check_stuff

  def on?
    self.value == "1"
  end
  def off?
    self.value == "0"
  end
  def edit_by_arduino?
    (self.ui_style =~ /conf$/).nil?
  end
  def conf_sensor?
    !(self.ui_style =~ /conf$/).nil?
  end
  
  protected
  def check_stuff
    if self.conf_sensor?
      self.value = self.arduino_value
    end
  end
  def set_event
    case self.ui_style
    when "on_off_button_temp_alarm"
      if !self.arduino_value.blank? && !self.max_arduino_value.blank?
        if self.arduino_value.to_i >= self.max_arduino_value.to_i
          # uri = URI.parse("http://#{I18n.t('config.server_host')}:#{I18n.t('config.server_port')}/alerts/#{self.id}/arduino_render")
          # Net::HTTP.post_form(uri, initheader = {'Content-Type' =>'application/json'})
        end
      end
    end
  end
end
