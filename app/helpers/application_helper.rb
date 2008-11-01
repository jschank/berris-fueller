# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def title(title)
    content_for(:title) { title }
  end
  
  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end
  
  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files) }
  end
  
  def version_info
    content_tag :p, "Version: #{APP_VERSION.to_s}", {:id => 'version_info'}
  end
  
  def user_logged_in?
    session[:user_id]
  end
  
  def user_is_admin?
    session[:user_id] && (user = User.find(session[:user_id])) && user.is_admin    
  end
  
end
