module ApiHelper
  def validate_auth_token
    self.resource = User.find_by_authentication_token(request.headers[:authorization])
    render :status => 401, :json => {errors: [t('api.token.invalid_token')]} if self.resource.nil?
  end
end
