module FleetsHelper
  def section(title, id=title.parameterize, default="minus")
    content_tag :div, :class => "toggle link", :id => "#{id}-handle" do
      content_tag :div, "", :class => default, :id => "#{id}-icon"
      content_tag :span, title, :class => "section-head link"
    end
  end
end
