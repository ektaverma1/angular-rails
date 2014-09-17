class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :restrict_access
  
  #Use this for Using HTTP Basic Authentication
  #http_basic_authenticate_with name: "admin", password: "secret"

  def index
  end

  private
  # def restrict_access
  # 	api_key = ApiKey.find_by_access_token(params[:access_token])
  # 	head :unauthorized unless api_key
  # end

  def restrict_access
  	authenticate_or_request_with_http_token do |token, options|
  		ApiKey.exists?(access_token: token)
  	end
  end

end
