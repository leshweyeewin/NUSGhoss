class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  respond_to :html, :json, :js

  def facebook
    if request.env["omniauth.auth"].info.email.blank?
      redirect_to "/users/auth/facebook?auth_type=rerequest&scope=email"
    end
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.nil?
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to root_url, notice: 'This email address is not registered on the site. Click on "Register" button to create an account.'
    else
      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      end
    end
  end
end