require_dependency "angular_blog/application_controller"

module AngularBlog
  class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    def index
      @posts = Post.visible(current_admin)
      @published_posts_count = AngularBlog::Post.where(published: true).where.not(published_on: nil).count
      respond_to do |format|
        format.html
        format.json 
        format.atom
      end
    end

    def show
      unless @post.nil? || @post.permapath.nil?
        path_array = @post.permapath.split("/")
        if path_array.length == 4
          redirect_to action: :show_post,
                    year: path_array[0],
                    month: path_array[1],
                    day: path_array[2],
                    parameterized_title: path_array[3]
        end
      end
    end

    def show_post
      @post = Post.where(permapath: params_to_permapath).last
      if @post.nil?
        not_found
      else
        render :show
      end
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
      if !@post.published
        if !!params[:published]
          @post.publish 
        end
      elsif !params[:published]
        @post.publish(false)
      end          
    end

    def params_to_permapath
      params[:year].to_s + "/" + params[:month].to_s + "/" + params[:day].to_s + "/" + params[:parameterized_title].to_s
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
        :blogger_id
      )
    end

    def not_found
      raise ActionController::RoutingError.new('Blog Post Not Found')
    end
  end
end
