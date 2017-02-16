module ApplicationHelper

  def auth_tokenn
    '<input type="hidden" name="authenticity_token" value="#{form_authenticity_token}">'.html_safe
  end
end
