module ApplicationHelper
  
  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end
  
  # def deliver_trust_message(trust_message = "This web site is requesting your trust.") 
  #   trust_uri = "http://#{request.host}/" 
  #   head 'eve.trustme' => "#{trust_uri}::#{trust_message}" 
  # end
  
  def request_trust(trust_url = "http://#{request.host}"+((request.port)?":#{request.port}":""), *args)
    trust_url = url_for(trust_url.merge(:only_path => false)) if trust_url.kind_of?(Hash)
    javascript_tag "CCPEVE.requestTrust(#{trust_url.inspect});", *args
  end
  
end
