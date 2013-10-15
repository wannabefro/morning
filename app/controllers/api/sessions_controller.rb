class Api::SessionsController < Devise::SessionsController
  prepend_before_action :require_no_authentication, :only => [:create]
  skip_before_action :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  # protect_from_forgery except: :create
  before_action :validate_auth_token, :except => :create
  include Devise::Controllers::Helpers
  include ApiHelper
  respond_to :json

  def create

    resource = User.find_for_database_authentication(:login => params[:session][:identification])
    return failure unless resource

    if resource.valid_password?(params[:session][:password])
      sign_in(:user, resource)
      resource.ensure_authentication_token!
      render :json=> {session: {:success => true, :authToken => resource.authentication_token}}
      return
    end
    failure
  end

  def destroy
    resource = resource_class.find_by_authentication_token(request.headers[:authorization])
    resource.reset_authentication_token!
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    render :status => 200, :json => {}
  end

  def failure
    return render json: { success: false, errors: [t('api.sessions.invalid_login')] }, :status => :unauthorized
  end

end
