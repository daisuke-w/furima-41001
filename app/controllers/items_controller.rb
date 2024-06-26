class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_top, only: :edit


  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render new_item_path, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return if current_user.id != @item.user_id

    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :category_id,
      :status_id,
      :shipping_cost_id,
      :prefecture_id,
      :shipping_duration_id,
      :name,
      :price,
      :description
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_top
    # 出品者と編集者が別人 もしくは 売却済みの場合はTopページに遷移
    redirect_to root_path if current_user.id != @item.user_id || @item.order.present?
  end
end
