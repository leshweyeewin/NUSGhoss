class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    if request.env["omniauth.auth"].info.email.blank?
      redirect_to "/users/auth/facebook?auth_type=rerequest&scope=email"
    end
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.nil?
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to "https://ivle.nus.edu.sg/api/login/?apikey=nt5s4waVtfzugEGRSuW5Z&url=http%3A%2F%2Flocalhost%3A3000%2Fusers%2Fsign_up"
    else
      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      end
    end
  end
end