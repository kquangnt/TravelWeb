class Admin::RestaurantsController < ApplicationController
  layout 'admin/layouts/admin_panel'

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    if @restaurant.save
      redirect_to admin_restaurant_path(@restaurant)
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update_attributes(restaurant_params)
      redirect_to admin_restaurant_path(@restaurant)
    else
      render  'edit'
    end
  end

  def destroy
    Restaurant.find(params[:id]).destroy
    redirect_to admin_restaurants_path
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name, :avatar, :province_id,
        :address, :email, :phone, :website, :details)
  end
end
