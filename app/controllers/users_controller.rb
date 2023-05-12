class UsersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  wrap_parameters format: []
  
  def show
    user = User.find_by(id: params[:id])
    render json: user, include: :items
  end

  private

  def render_not_found
    render json:{error: invalid.record.errors}, status: :not_found
  end

end
