require_dependency "angular_blog/application_controller"

module AngularBlog
  class TagsController < ApplicationController
    before_action :set_tag, only: [:show, :edit, :update, :destroy]

    def index
      @tags = Tag.all.order(created_at: :asc)
    end

    def show
    end

    def new
      @tag = Tag.new
    end

    def edit
    end

    def create
      @tag = Tag.new(tag_params)

      respond_to do |format|
        if @tag.save
          format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
          format.json { render action: 'show', status: :created, location: @tag }
        else
          format.html { render action: 'new' }
          format.json { render json: @tag.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @tag.update(tag_params)
          format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @tag.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @tag.destroy
      respond_to do |format|
        format.html { redirect_to tags_url }
        format.json { head :no_content }
      end
    end

  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(
        :id,  
        :_destroy, 
        :is_sticky,
        :subject
      )
    end
  end
end
