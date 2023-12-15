class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[show index]

  def my_posts
    @posts = Post.includes([:user]).where(user_id: params[:user_id])
  end

  # GET /posts or /posts.json
  def index
    @posts = Post.includes([:user]).all.order(created_at: :desc)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post.update(views: @post.views + 1)
    @comments = @post.comments.includes([:user, :rich_text_body])
    mark_notification_as_read
  end

  # GET /posts/new
  def new
    @post = Post.new( body: "questo è un nuovo post")
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      par = post_params
      #par[:slug] = par[:title]
      if @post.update(par)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|

      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      redirect_to @post, status: :moved_permanently if params[:id] !=@post.slug
    end

    def set_my_posts
      @post = Post.where(params[:user_name])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :slug)

      
    end

    def mark_notification_as_read
      if current_user
        notifications_to_mark_as_read = @post.notifications_as_post.where(recipient: current_user)
        notifications_to_mark_as_read.each do |notification|  
          notification.mark_as_read!
        end
      end
    end

    
end
