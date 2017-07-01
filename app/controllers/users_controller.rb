class UsersController < ApplicationController
	before_action :require_login, except: [:index, :create, :new]

  def show
  	@user = User.find(params[:id])
  end

  def index
  	#renders page to login or register
  end

  def new
  	#renders page to register user (new.html.erb)
  end

  def create
  	user = User.create(user_params)
  	if user.valid?
  		session[:user_id] = user.id
  		redirect_to '/secrets'
  	else
  		flash[:registration_errors] = user.errors.full_messages
  		redirect_to '/users/new'
  	end
  end

  private

  def session_does_not_equal_params
  	# if user in session is not equal to user being passed in url, redirect
  	if session[:id] != params[:id]
  		redirect_to "users/#{session[:id]}"
  	end
  end
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
