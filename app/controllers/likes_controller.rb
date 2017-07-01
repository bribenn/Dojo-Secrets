class LikesController < ApplicationController
	before_action :require_login 
  def create
  	like = Like.create(user: current_user, secret: Secret.find(params[:secret_id]))
  	redirect_to '/secrets'
  end

  def destroy
  	like = Like.find_by(user: current_user, secret: Secret.find(params[:secret_id])).destroy
  	redirect_to :back
  end
end
