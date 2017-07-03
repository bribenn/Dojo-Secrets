class SecretsController < ApplicationController

	before_action :require_login

  def index
  	@secrets = Secret.all.includes(:likes, :user).order('created_at DESC')
  	@secrets_liked = current_user.secrets_liked_ids
  end

  def create
  	secret = Secret.create(secret_params.merge(user: current_user))
  	if secret.valid?
  		redirect_to :back
  	else
  		flash[:secret_errors] = secret.errors.full_messages
  		redirect_to "/users/#{session[:user_id]}"
  	end
  end

  def destroy
  	secret = Secret.find(params[:secret_id]).destroy
  	redirect_to :back
  end

  private
  def secret_params
  	params.require(:secret).permit(:content)
  end
end
