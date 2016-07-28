class PagesController < ApplicationController
  before_action :set_auth
  before_action :set_to_follow!

  def home
  	@posts = Post.all
    if user_signed_in?
      @newPost = Post.new
      @followers_count = current_user.followers.count
    end
  end

  def profile
    if (User.find_by(:id => params[:id]))
      @id = params[:id]
      @user = User.find_by(:id => params[:id])
      @profile_image = @user.profile_image
    else
      redirect_to root_path, :notice=> "User not found"
    end

    @posts = Post.all.where("user_id = ?", User.find_by(:id => @id))
    
    if user_signed_in?
      @newPost = Post.new
      @followers_count = @user.followers.count
    end
  end

  private
  def set_auth
  	auth = session[:omniauth] if session[:omniauth]
  end
end
