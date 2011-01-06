# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def current_path
    excluded_links = ["type", "room", "outdoor", "range"]
    returning [] do |path|
      url = request.path.split('?')
      path << link_to("Home", root_path)
      segments = url[0].split('/')
      segments.shift
      segments.each_with_index do |segment, i|
        next if excluded_links.include? segment
        segment = CGI.unescape(segment)
        title = segment.gsub(/\d/, '').gsub(/-/, ' ').titleize
        path << link_to_unless_current(title, "/" + (0..(i)).collect{|seg| segments[seg]}.join("/")) unless title.blank?
      end
    end
  end

  def breadcrumbs
    content_tag("div", current_path.join(" &#187; "), :id => "breadcrumbs")
  end


  def seo(s)
    return s.gsub(/[^-_\s\w]/, '').downcase.squeeze(' ').tr(' ','-')
  end



  # if there are multiple actions passed through, the first is assumed to be the priority link!
  def section_link(name,options)
      #logger.debug("MSP @current_action: #{@current_action} @current_controller: #{@current_controller}")
      if options[:action].include?(@current_action) && options[:controller] == @current_controller
         link_to(name, "/"+ options[:url], :class => 'current')
      else
        link_to(name, "/"+ options[:url])
      end
  end

  def highlight_this?(product, selected_product, additional_class)
    if !selected_product.nil?
      highlight = product.id == selected_product.id ? "highlighted_product" : ""
      return "#{highlight} #{additional_class}"
    else
      return additional_class
    end
  end


  def w3c_date(date)
      date.strftime("%Y-%m-%dT%H:%M:%S+00:00")
  end


  
end
