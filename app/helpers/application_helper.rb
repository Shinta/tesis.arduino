module ApplicationHelper
  
  def display_base_errors resource
    return '' if resource.errors.empty?
    messages = resource.errors.values.map { |msg| content_tag(:p, msg.first) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end
  
  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse("http://#{t('config.faye_server')}:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

end
