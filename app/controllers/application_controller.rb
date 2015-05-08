class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_tracking_cookie, :set_layout_variables
  after_action :allow_iframe

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
          :type => 'article',
          :url => request.original_url
        }
      }
    end

    def require_admin
      if !current_user || !current_user.is_admin?
        render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
        return false
      end
    end

    def allow_iframe
      response.headers.except! 'X-Frame-Options'
    end
end
