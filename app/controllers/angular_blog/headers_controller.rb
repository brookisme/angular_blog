require_dependency "angular_blog/application_controller"

module AngularBlog
  class HeadersController < ApplicationController
    before_action :set_header, only: [:show, :edit, :update, :destroy]

    def index
      @headers = Header.all.order(created_at: :asc)
    end

    def show
    end

    def new
      @header = Header.new
    end

    def edit
    end

    def create
      @header = Header.new(header_params)

      respond_to do |format|
        if @header.save
          format.html { redirect_to @header, notice: 'Header was successfully created.' }
          format.json { render action: 'show', status: :created, location: @header }
        else
          format.html { render action: 'new' }
          format.json { render json: @header.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @header.update(header_params)
          format.html { redirect_to @header, notice: 'Header was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @header.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @header.destroy
      respond_to do |format|
        format.html { redirect_to headers_url }
        format.json { head :no_content }
      end
    end

  private
    def set_header
      @header = Header.find(params[:id])
    end

    def header_params
      params.require(:header).permit(
        :id,  
        :_destroy, 
        :is_sticky,
        :subject
      )
    end
  end
end
