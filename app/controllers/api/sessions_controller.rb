class Api::SessionsController < Devise::SessionsController

  def create
    user = warden.authenticate!(:scope => :user)
    token = Tiddle.create_and_return_token(user, request)
    render json: { authentication_token: token }
  end

  def destroy
    if current_user && Tiddle.expire_token(current_user, request)
      head :ok
    else
      render json: { error: 'invalid token' }, status: 401
    end
  end

end
