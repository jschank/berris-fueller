# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # require 'aasm'
  include AuthenticatedSystem

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'ac53ea3e47796b37cba6ca858df7c2e8'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

protected
  # Protect controllers with code like:
  #   before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  def admin_required
    current_user.respond_to?('is_admin') && current_user.send('is_admin')
  end

end
