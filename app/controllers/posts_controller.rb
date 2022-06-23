class PostsController < ApplicationController
  before_action :set_post, except: [:index, :new, :create]
  before_action :authorize_user_post, only:[:edit,:update]
  def index
    @posts = Post.order(:post_name).page params[:page]
  end
  def show
  end
  def new
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    if @post.save
      PostMailer.with(post: @post).new_post_email.deliver_now
      flash[:notice] = "Congratulations! Your post is published."
      redirect_to @post
    else
      render :new
    end
  end
  
  def edit
  end
  def update 
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end
  def destroy
    @post.destroy
    redirect_to root_path
  end 

  private
  def post_params
    params.require(:post).permit(:post_name, :post_description, :user_id, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end
  def authorize_user_post
    if !current_user.posts.pluck(:id).include?(@post.id)
      flash[:notice] = "You are not authorized to edit this post"
     redirect_to root_path
    end
  end
end
