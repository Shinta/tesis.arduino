class SensorGroup < ActiveRecord::Base
  has_many :sensors
  attr_accessible :name
end
