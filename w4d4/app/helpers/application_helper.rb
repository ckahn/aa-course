module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def csrf_protection
    html = <<-HTML
      <input
        type="hidden"
        name="authenticity_token"
        value="#{form_authenticity_token}">
    HTML
    html.html_safe
  end

  def logged_in?(user)
    session[:session_token] == user.session_token
  end
end
