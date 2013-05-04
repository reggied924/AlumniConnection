class SessionsController < ApplicationController
  skip_before_filter :signed_in_user
  
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      session[:user_id] = user.id
      respond_to do |format|
              format.html {redirect_back_or user}
              format.json  { render :text => "Valid user/password combination" }
            end
    else
    flash.now[:error] = 'Invalid email/password combination'
    respond_to do |format|
            format.html {render "new"}
            format.json  { render :text => "Invalid user/password combination" }
          end
    #  flash.now[:error] = 'Invalid email/password combination'
    #  render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
