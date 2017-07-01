class SessionsController < ApplicationController
  before_action :require_login, except: [:new, :create]
  def new
  	# render login page	
  end

  def create
  	user = User.find_by(email: login_params[:email])
  	if user && user.authenticate(login_params[:password])
  		session[:user_id] = user.id
  		redirect_to '/secrets'
  	else 
  		flash[:login_error] = 'invalid credentials'
  		redirect_to '/sessions/new'
  	end
  end

  def destroy
  	reset_session
  	redirect_to '/'
  end

  private
  def login_params
  	params.require(:login).permit(:email, :password)
  end
end
