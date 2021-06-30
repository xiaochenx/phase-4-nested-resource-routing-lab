class ItemsController < ApplicationController

  def index
    if params[:user_id]
      # byebug
      user = User.find_by(id: params[:user_id])
      if user
        items = user.items
      else
        return render json: { error: "User not found"}, status: 404
      end
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    user = User.find_by(id: params[:user_id])
    if user
        item = user.items.find_by(id: params[:id])
        if item
          render json: item, include: :user
        else
          render json: { error: "Item not found"}, status: 404
        end
    else
      render json: { error: "User not found"}, status: 404
    end
  end

  def create
    user = User.find_by(id: params[:user_id])
    item = user.items.create(item_params)
    
    render json: item, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end
end






