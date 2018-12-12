class Api::DashboardController < ActionController::API
  def load
    render json: current_user.dashboard_layout
  end

  def save
    if current_user.update(dashboard_layout: layout_params)
      render json: { success: 'Success' }, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }
    end
  end

  private

  def layout_params
    params.permit(layout: [:i, :x, :y, :w, :h, :moved, :static, :minH, :minW, :maxH, :maxW])
  end
end
