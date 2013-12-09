module ApplicationHelper
  def draw_action_header(header = nil)
    header ||= "#{controller_name}.#{action_name}".titleize
    render 'layouts/action_header', :header => header
  end

  def draw_subject_status(subject)
    case subject.status
    when Subject::Status::INBOX
      content_tag :span, "Inbox", :class => "label label-primary"
    when Subject::Status::IGNORED
      content_tag :span, "Ignored", :class => "label label-default"
    when Subject::Status::CARED
      content_tag :span, "Cared", :class => "label label-danger"
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
