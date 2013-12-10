module ApplicationHelper
  def draw_action_header(header = nil)
    header ||= "#{controller_name}.#{action_name}".titleize
    render 'layouts/action_header', :header => header
  end

  def draw_button_to(title, url, options = {})
    content_tag :button, :class => "btn btn-default" do
      link_to title, url, options
    end
  end

  def draw_topic_status(topic)
    case topic.status
    when Topic::Status::INBOX
      content_tag :span, "收件箱", :class => "label label-danger"
    when Topic::Status::CARED
      content_tag :span, "已关注", :class => "label label-warning"
    when Topic::Status::IGNORED
      content_tag :span, "已忽略", :class => "label label-info"
    when Topic::Status::NONE
      content_tag :span, "无状态", :class => "label label-default"
    end
  end

  def sidebar_link_to(title, style, count, path)
    content_tag :li, current_page?(path) ? {:class => "active"} : {} do
      content_tag :a, :href => path do
        contents = []
        contents << title
        contents << content_tag(:span, count, :class => "badge pull-right")
        contents.join.html_safe
      end
    end
  end

  # def sidebar_link_to(title, style, count, path)
  #   content_tag :li, current_page?(path) ? {:class => "active"} : {} do
  #     content_tag :a, :href => path do
  #       contents = []
  #       #contents << content_tag(:span, title, :class => "text-#{style}")
  #       #contents << content_tag(:span, count, :class => "badge pull-right")

  #       contents << content_tag(:div, title, :class => "alert alert-#{style}")

  #       #contents << title
  #       #contents << content_tag(:span, title, :class => "label label_#{status_class} ")
  #       #contents << content_tag(:strong, count, :class => "label label_#{status_class} large pull-right")
  #       #contents << content_tag(:p, count, :class => "text-#{status_class} pull-right")
  #       contents.join.html_safe
  #     end
  #   end
  # end

  # def sidebar_link_to(title, style, count, path)
  #   content_tag :div, :class => "alert alert-#{style}" do
  #     content_tag :a, title, :href => path
  #   end
  # end

end
