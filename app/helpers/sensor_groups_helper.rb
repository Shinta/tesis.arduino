module SensorGroupsHelper
  
  def show_ui(sensor)
    case sensor.ui_style
    when "on_off_button"
      html = "<fieldset id=\"sensor_#{sensor.id}\"><legend>#{sensor.name}</legend>"
      html += "<ul class=\"inline\">"
    	if sensor.on?
        html += <<-HTML
    		<li>#{link_to "Encender", "#", :class => "btn btn-large disabled"}</li>
    		<li>#{link_to "Apagar", change_sensor_path(sensor, 0), :class => "btn btn-large btn-danger", :remote => true, :data => {:disable_with => "<i class=\"fa fa-spinner fa-spin\"></i>"}}</li>
        HTML
      else
        html += <<-HTML
    		<li>#{link_to "Encender", change_sensor_path(sensor, 1), :class => "btn btn-large btn-success", :remote => true, :data => {:disable_with => "<i class=\"fa fa-spinner fa-spin\"></i>"}}</li>
    		<li>#{link_to "Apagar", "#", :class => "btn btn-large disabled", :disabled => true}</li>
        HTML
      end
    	html += "</ul></fieldset>"
    when "on_off_button_temp_alarm"
      html = "<fieldset id=\"sensor_#{sensor.id}\"><legend>#{sensor.name}: #{sensor.arduino_value} C</legend>"
      html += "<ul class=\"inline\">"
    	if sensor.on?
        html += <<-HTML
    		<li>#{link_to "Encender", "#", :class => "btn btn-large disabled"}</li>
    		<li>#{link_to "Apagar", change_sensor_path(sensor, 0), :class => "btn btn-large btn-danger", :remote => true, :data => {:disable_with => "<i class=\"fa fa-spinner fa-spin\"></i>"}}</li>
        HTML
      else
        html += <<-HTML
    		<li>#{link_to "Encender", change_sensor_path(sensor, 1), :class => "btn btn-large btn-success", :remote => true, :data => {:disable_with => "<i class=\"fa fa-spinner fa-spin\"></i>"}}</li>
    		<li>#{link_to "Apagar", "#", :class => "btn btn-large disabled", :disabled => true}</li>
        HTML
      end
    	html += "</ul></fieldset>"
    when "open_close_button"
      html = "<fieldset id=\"sensor_#{sensor.id}\"><legend>#{sensor.name}</legend>"
      html += "<ul class=\"inline\">"
    	if sensor.on?
        html += <<-HTML
    		<li>#{link_to "Abrir", "#", :class => "btn btn-large disabled"}</li>
    		<li>#{link_to "Cerrar", change_sensor_path(sensor, 0), :class => "btn btn-large btn-danger", :remote => true, :data => {:disable_with => "<i class=\"fa fa-spinner fa-spin\"></i>"}}</li>
        HTML
      else
        html += <<-HTML
    		<li>#{link_to "Abrir", change_sensor_path(sensor, 1), :class => "btn btn-large btn-success", :remote => true, :data => {:disable_with => "<i class=\"fa fa-spinner fa-spin\"></i>"}}</li>
    		<li>#{link_to "Cerrar", "#", :class => "btn btn-large disabled", :disabled => true}</li>
        HTML
      end
    	html += "</ul></fieldset>"
    when "label_temp"
      html = "<fieldset id=\"sensor_#{sensor.id}\"><legend>#{sensor.name}: #{sensor.arduino_value} C</legend>"
      html += "</fieldset>"
    when "label_humidity"
      html = "<fieldset id=\"sensor_#{sensor.id}\"><legend>#{sensor.name}: #{sensor.arduino_value} %</legend>"
      html += "</fieldset>"
    when "text_field_conf"
      html = "<fieldset class=\"text_field_conf\" id=\"sensor_#{sensor.id}\"><legend>#{sensor.name}</legend>"
      html += capture do
        form_for(sensor, :html => {:class => "form-inline"}, :remote => true) do |f|
          concat f.text_field(:arduino_value, :class => "input-mini text_field_conf")
          concat f.submit("Actualizar", :class => "btn btn-large btn-primary", :disable_with => "Guardando ...")
        end
      end
    	html += "</fieldset>"
    end
    html.html_safe
  end
  
end
