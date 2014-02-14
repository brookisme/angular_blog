require_dependency "angular_blog/application_controller"

module AngularBlog
  class BlurbsController < ApplicationController
    before_action :set_blurb, only: [:show, :edit, :update, :destroy]

    def index
      @blurbs = Blurb.all.order(created_at: :asc)
    end

    def show
    end

    def new
      @blurb = Blurb.new
    end

    def edit
    end

    def create
      @blurb = Blurb.new(blurb_params)

      unless params[:component_id].blank?
        @blurb.component = Component.where(id: params[:component_id]).last
      end

      respond_to do |format|
        if @blurb.save
          format.html { redirect_to @blurb, notice: 'Blurb was successfully created.' }
          format.json { render action: 'show', status: :created, location: @blurb }
        else
          format.html { render action: 'new' }
          format.json { render json: @blurb.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @blurb.update(blurb_params)
          format.html { redirect_to @blurb, notice: 'Blurb was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @blurb.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @blurb.destroy
      respond_to do |format|
        format.html { redirect_to blurbs_url }
        format.json { head :no_content }
      end
    end

  private
    def set_blurb
      @blurb = Blurb.find(params[:id])
    end

    def blurb_params
      params.require(:blurb).permit(
        :id,  
        :_destroy, 
        :content,
        :size
      )
    end
  end
end
