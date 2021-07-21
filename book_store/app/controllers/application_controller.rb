class ApplicationController < ActionController::API
  recue_from ActiveRecord::RecordNotDestroyed, with :not_destroyed

  private

  def not_destroyed(e)
    render json: {errors: e.record.errors}, status: :unprocessable_entity
  end
end
