class ApplicationController < ActionController::API
  # rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  # def not_destroyed(e)
  #   obj = { errors: e.record.errors }
  #   render json: obj, status: :unprocessable_entity
  # end
end
