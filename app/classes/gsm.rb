require 'serialport'
class GSM
  
  attr_accessor :com, :debug
  
  def initialize(options = {})
    port_str = "/dev/tty.HUAWEIMobile-Modem"  #may be different for you
    baud_rate = 38400
    data_bits = 8
    stop_bits = 1
    parity = SerialPort::NONE
    @com = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
    @debug = options[:debug] || false
    cmd("AT")
    cmd("AT+CMGF=1") # Set to text mode.
  end
  
  def close
    @com.close
  end
  
  def cmd(cmd)
    @com.write(cmd + "\r")
    wait
  end
  
  def wait
    buffer = ''
    while IO.select([@com], [], [], 0.25)
      chr = @com.getc.chr
      buffer += chr
    end
    buffer
  end
  
  def send_sms(options = {})
    options[:message] = ActionView::Base.full_sanitizer.sanitize(options[:message])
    cmd("AT+CMGS=\"#{options[:number]}\"")
    cmd("#{options[:message][0..140]}#{26.chr}\r\r")
    sleep 1
    wait
    cmd("AT")
    puts "[DEBUG] \"#{options[:message]}\" sent to #{options[:number]}" if @debug
  end
  
end
