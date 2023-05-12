class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user != nil
        items = user.items
      else
        return render json:{error: 'User not found'}, status: :not_found
      end
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find_by(id: params[:id])
    if item != nil
      render json: item, include: :user
    else
      return render json:{error: 'Item not found'}, status: :not_found
    end
  end 

  def create
    item = Item.create(item_params)
    render json: item, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

end
