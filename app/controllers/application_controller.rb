class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_tracking_cookie, :set_layout_variables

  protected

    def set_tracking_cookie
      cookies.permanent[:uuid] = SecureRandom.uuid unless cookies[:uuid]
    end

    def set_layout_variables
      @layout = {
        :og => {
          :image => 'http://policy-assessment.herokuapp.com/assets/images/freddie-gray-protest.jpg',
          :title => 'Policing Policy Assessment',
          :description => 'Policy checklist for your local police department.',
          :url => request.original_url
        }
      }
    end
end
