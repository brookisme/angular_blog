require_dependency "angular_blog/application_controller"

module AngularBlog
  class ComponentsController < ApplicationController
    before_action :set_component, only: [:show, :edit, :update, :destroy]

    def index
      @components = Component.all.order(created_at: :asc)
    end

    def show
    end

    def new
      @component = Component.new
    end

    def edit
    end

    def create
      @component = Component.new(component_params)

      respond_to do |format|
        if @component.save
          format.html { redirect_to @component, notice: 'Component was successfully created.' }
          format.json { render action: 'show', status: :created, location: @component }
        else
          format.html { render action: 'new' }
          format.json { render json: @component.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @component.update(component_params)
          format.html { redirect_to @component, notice: 'Component was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @component.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @component.destroy
      respond_to do |format|
        format.html { redirect_to components_url }
        format.json { head :no_content }
      end
    end

  private
    def set_component
      @component = Component.find(params[:id])
    end

    def component_params
      params.require(:component).permit(
        :id,  
        :_destroy, 
        :post_id,
        :postable_id,
        :postable_type,
        :index,
        :width,
        :height,
        :link,
        :css_string
      )
    end

  end
end
