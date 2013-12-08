module ApplicationHelper
  def draw_action_header(header = nil)
    header ||= "#{controller_name}.#{action_name}".titleize
    render 'layouts/action_header', :header => header
  end

  def draw_topic_status(topic)
    case topic.status
    when Subject::Status::INBOX
      content_tag :span, "Inbox", :class => "label label-primary"
    when Subject::Status::IGNORED
      content_tag :span, "Ignored", :class => "label label-default"
    when Subject::Status::CARED
      content_tag :span, "Cared", :class => "label label-danger"
    end
  end

  def title_badge(title, badge)
    "#{title} <span class='badge'>#{badge}</span>".html_safe
  end
end
