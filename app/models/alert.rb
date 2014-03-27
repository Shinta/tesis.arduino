class Alert < ActiveRecord::Base
  attr_accessible :description, :sensor_id, :style, :status
  
  scope :important, where("style = 'main_alarm' and status = 'pending'")
  scope :main_alarms, where("style = 'main_alarm' and status = 'pending'")
  
  def spam_notifications(options)
    users = User.to_notificate
    unless users.empty?
      gsm = GSM.new(options)
      for user in users
        gsm.send_sms(:number => "+595#{user.cellphone}", :message => self.description)
      end
    end
  end
  
  def self.turn_off_main_alarm
    for alert in Alert.main_alarms
      alert.status = 'closed'
      alert.save
    end
  end

end
