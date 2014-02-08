module SurveyBase
  module Angularable
  extend ActiveSupport::Concern
    def template
      @path = params[:path]
      render template: '/angular_blog/angularjs/' + @path, :layout => nil
    end
  end
end
