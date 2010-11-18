module FleetsHelper

  def section(title, id=title.parameterize, default="minus")
    content_tag :div, :class => "toggle", :id => "#{id}-handle" do
      # tag :div, :class => default, :id => "#{id}-icon"
      content_tag :a, title, :class => "section-head"
    end
  end
  
  def summarize(fleet)
    output = ""
    first_line = true
    fleet.summarize.each do |sys|
      item = "#{sys[1].count} in #{sys[0]}"
      if first_line == true
        item += " (#{(sys[1].count.to_f / fleet.users.count.to_f * 100).round}%)" 
        first_line = false
      end
      count = 0
      first = true
      sys[1].each do |user|
        if user.tag
          item += " [ " if first
          item += "#{user.tag.text} (#{user.char_name}) "
          first = false
        else
          count = count + 1
        end
      end
      item += "+ #{pluralize(count, "other")} " unless (first || count == 0)
      item += "]" unless first
      output += content_tag :li, item
    end
    return output.html_safe
  end

end