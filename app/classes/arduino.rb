require 'serialport'
class Arduino
  
  attr_accessor :com
  
  def initialize
    port_str = "/dev/tty.usbmodemfd1211"  #may be different for you
    baud_rate = 9600
    data_bits = 8
    stop_bits = 1
    parity = SerialPort::NONE
    @com = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
    @com.read_timeout = 100
  end
  
  def close
    @com.close
  end
  
  def write(value)
    @com.write value
  end
  
  def read
    response = @com.gets
    response.chomp if response
  end
  
end
