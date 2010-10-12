module FleetsHelper
  def section(title, id=title.parameterize, default="minus")
    content_tag :div, :class => "toggle", :id => "#{id}-handle" do
      # tag :div, :class => default, :id => "#{id}-icon"
      content_tag :a, title, :class => "section-head"
    end
  end
end