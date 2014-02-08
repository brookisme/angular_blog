module AngularBlog
  class ApplicationController < ActionController::Base
    include SurveyBase::Restrictable
  end
end
