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
