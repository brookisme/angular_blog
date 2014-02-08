require_dependency "angular_blog/application_controller"

module AngularBlog
  class PostTagsController < ApplicationController
    before_action :set_post_tag, only: [:show, :edit, :update, :destroy]

    def index
      @post_tags = PostTag.all.order(created_at: :asc)
    end

    def show
    end

    def new
      @post_tag = PostTag.new
    end

    def edit
    end

    def create
      @post_tag = PostTag.new(post_tag_params)

      respond_to do |format|
        if @post_tag.save
          format.html { redirect_to @post_tag, notice: 'PostTag was successfully created.' }
          format.json { render action: 'show', status: :created, location: @post_tag }
        else
          format.html { render action: 'new' }
          format.json { render json: @post_tag.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @post_tag.update(post_tag_params)
          format.html { redirect_to @post_tag, notice: 'PostTag was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @post_tag.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @post_tag.destroy
      respond_to do |format|
        format.html { redirect_to post_tags_url }
        format.json { head :no_content }
      end
    end

  private
    def set_post_tag
      @post_tag = PostTag.find(params[:id])
    end

    def post_tag_params
      params.require(:post_tag).permit(
        :id,  
        :_destroy, 
        :is_sticky,
        :subject
      )
    end
  end
end
