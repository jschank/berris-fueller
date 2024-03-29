class UsersController < ApplicationController
  # Protect these actions behind an admin login
  before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge, :show]
  

  # GET /users/1
  # GET /users/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # render new.rhtml
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
      redirect_to login_path
      # redirect_back_or_default('/')
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to login_path
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_to login_path
      # redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_to login_path
      # redirect_back_or_default('/')
    end
  end

  def suspend
    @user.suspend! 
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end

  def destroy
    @user.delete!
    redirect_to users_path
  end

  def purge
    @user.destroy
    redirect_to users_path
  end
  
  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

  def account
    if logged_in?
      @user = current_user
    else
      flash[:alert] = 'You are not logged in - please login first'
      render :controller => 'session', :action => 'new'
    end
  end

  # action to perform when the user wants to change their password
  def change_password
    return unless request.post?
    if User.authenticate(current_user.login, params[:old_password])
      #      if (params[:password] == params[:password_confirmation])
      current_user.password_confirmation = params[:password_confirmation]
      current_user.password = params[:password]
      if current_user.save
        flash[:notice] = "Password updated successfully"
        redirect_to account_url
      else
        flash[:alert] = "Password not changed"
      end
      #      else
      #        flash[:alert] = "New password mismatch"
      #        @old_password = params[:old_password]
      #      end
    else
      flash[:alert] = "Old password incorrect"
    end
  end

  # action to perform when the users clicks forgot_password
  def forgot_password
    return unless request.post?
    if @user = User.find_by_email(params[:user][:email])
      @user.forgot_password
      @user.save
      redirect_back_or_default('/')
      flash[:notice] = "A password reset link has been sent to your email address: #{params[:user][:email]}"
    else
      flash[:alert] = "Could not find a user with that email address: #{params[:user][:email]}"
    end
  end

  # action to perform when the user resets the password
  def reset_password
    @user = User.find_by_password_reset_code(params[:code])
    return if @user unless params[:user]

    if ((params[:user][:password] && params[:user][:password_confirmation]))
      self.current_user = @user # for the next two lines to work
      current_user.password_confirmation = params[:user][:password_confirmation]
      current_user.password = params[:user][:password]
      @user.reset_password
      flash[:notice] = current_user.save ? "Password reset successfully" : "Unable to reset password"
      redirect_back_or_default('/')
    else
      flash[:alert] = "Password mismatch"
    end
  end

protected
  def find_user
    @user = User.find(params[:id])
  end
end
