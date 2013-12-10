module ApplicationHelper
  def draw_action_header(header = nil)
    header ||= "#{controller_name}.#{action_name}".titleize
    render 'layouts/action_header', :header => header
  end

  def draw_topic_status(topic)
    case topic.status
    when Topic::Status::INBOX
      content_tag :span, "收件箱", :class => "label label-primary"
    when Topic::Status::IGNORED
      content_tag :span, "已忽略", :class => "label label-default"
    when Topic::Status::CARED
      content_tag :span, "已关注", :class => "label label-danger"
    when Topic::Status::NONE
      content_tag :span, "无状态", :class => "label label-default"
    end
  end

  def sidebar_link_to(title, count, path)
    content_tag :li, current_page?(path) ? {:class => 'active'} : {} do
      content_tag :a, :href => path do
        contents = []
        contents << title
        contents << content_tag(:span, count, :class => 'badge pull-right')
        contents.join.html_safe
      end
    end
  end

end
