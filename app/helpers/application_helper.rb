module ApplicationHelper
  def draw_action_header(header = nil)
    header ||= "#{controller_name}.#{action_name}".titleize
    render 'layouts/action_header', :header => header
  end

  def draw_button_to(title, url, options = {})
    link_to title, url, {:class => "btn btn-default"}.merge(options)
  end

  def sidebar_link_to(title, path, count = 0)
    content_tag :li, current_page?(path) ? {:class => "active"} : {} do
      content_tag :a, :href => path do
        contents = []
        contents << title
        if count > 0
          contents << content_tag(:span, count, :class => "badge pull-right")
        end
        contents.join.html_safe
      end
    end
  end

end
