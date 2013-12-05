module ApplicationHelper
  def draw_action_header(header = nil)
    header ||= "#{controller_name}.#{action_name}".titleize
    render 'layouts/action_header', :header => header
  end

  def title_badge(title, badge)
    "#{title} <span class='badge'>#{badge}</span>".html_safe
  end
end
