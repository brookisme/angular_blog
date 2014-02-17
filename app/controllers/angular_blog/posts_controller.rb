require_dependency "angular_blog/application_controller"

module AngularBlog
  class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    def index
      @posts = Post.visible(current_admin)
      respond_to do |format|
        format.html
        format.json 
        format.atom 
      end
    end

    def show
    end

    def new
      @post = Post.new
    end

    def edit
    end

    def create
      @post = Post.new(post_params)
      process_post
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { render action: 'show', status: :created, location: @post }
        else
          format.html { render action: 'new' }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      process_post
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url }
        format.json { head :no_content }
      end
    end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def process_post
      (@post.published_on = Time.now) if (!@post.published && params[:published])
    end

    def post_params
      params.require(:post).permit(
        :id,  
        :_destroy, 
        :is_sticky,
        :subject,
        :display_subject,
        :accept_comments,
        :comments_closed,
        :published,
        :blogger_id
      )
    end
  end
end
