class SessionController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    mail_id = auth['info']['email']
    
    if Admin.sign_in_from_omniauth(mail_id).present?
      admin = Admin.sign_in_from_omniauth(mail_id)
      session[:omniauth] = auth.except('extra')
      session[:user_id] = admin.id
      redirect_to root_path, notice: "Signed In Successfully"
    else
      redirect_to root_path, notice: "You don't have log in permission"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:omniauth] = nil
    redirect_to root_path, notice: "Signed Out"
  end
end
