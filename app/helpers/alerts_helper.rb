module AlertsHelper
  
  def render_alert(alert)
    case alert.style
    when "error"
      html = <<-HTML
      <div class="alert alert-error alert-block" id="alert_#{alert.id}">
        <button type="button" class="close" data-dismiss="alert">&#215;</button>
        #{alert.description}
      </div>
      HTML
    when "warning"
      html = <<-HTML
      <div class="alert alert-warning alert-block" id="alert_#{alert.id}">
        <button type="button" class="close" data-dismiss="alert">&#215;</button>
        #{alert.description}
      </div>
      HTML
    when 'main_alarm'
      html = <<-HTML
      <div class="alert alert-error alert-block main-alert" id="alert_#{alert.id}">
        <h4>Alarma Principal</h4>
        #{alert.description} #{link_to("Apagar Alarma", :alerts_turn_off_main_alarm, :class => "btn btn-small btn-warning")}
      </div>
      HTML
    when 'notice'
      html = <<-HTML
      <div class="alert alert-info alert-block" id="alert_#{alert.id}">
        <button type="button" class="close" data-dismiss="alert">&#215;</button>
        #{alert.description}
      </div>
      HTML
    end
    html.html_safe
  end
  
  def render_important_alerts
    html = ""
    for alert in Alert.important
      html += render_alert(alert)
    end
    html.html_safe
  end
  
  def table_style(alert)
    case alert.style
    when "error", "main_alarm"
      " class=\"error\"".html_safe
    when "warning"
      " class=\"warning\"".html_safe
    when "notice"
      " class=\"info\"".html_safe
    end
  end

end
