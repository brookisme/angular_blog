require_dependency "angular_blog/application_controller"

module AngularBlog
  class VideosController < ApplicationController
    before_action :set_video, only: [:show, :edit, :update, :destroy]

    def index
      @videos = Video.all.order(created_at: :asc)
    end

    def show
    end

    def new
      @video = Video.new
    end

    def edit
    end

    def create
      @video = Video.new(video_params)

      respond_to do |format|
        if @video.save
          format.html { redirect_to @video, notice: 'Video was successfully created.' }
          format.json { render action: 'show', status: :created, location: @video }
        else
          format.html { render action: 'new' }
          format.json { render json: @video.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @video.update(video_params)
          format.html { redirect_to @video, notice: 'Video was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @video.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @video.destroy
      respond_to do |format|
        format.html { redirect_to videos_url }
        format.json { head :no_content }
      end
    end

  private
    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(
        :id,  
        :_destroy, 
        :is_sticky,
        :subject
      )
    end
  end
end
