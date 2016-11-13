class Admin::HotelsController < Admin::BaseController

  def index
    @hotels = Hotel.paginate(page: params[:page])
    if params[:search]
      @hotels = Hotel.search(params[:search]).paginate(page: params[:page])
    else
      @hotels = Hotel.paginate(page: params[:page])
    end
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = Hotel.create(hotel_params)
    if @hotel.save
      redirect_to admin_hotel_path(@hotel)
    else
      render 'new'
    end
  end

  def show
    @hotel = Hotel.find(params[:id])
  end

  def edit
    @hotel = Hotel.find(params[:id])
  end

  def update
    @hotel = Hotel.find(params[:id])
    if @hotel.update_attributes(hotel_params)
      redirect_to admin_hotel_path(@hotel)
    else
      render 'edit'
    end
  end

  def destroy
    Hotel.find(params[:id]).destroy
    redirect_to admin_hotels_path
  end

  private
  def hotel_params
    params.require(:hotel).permit(:name, :province_id, :address, :phone, 
        :email, :website, :details)
  end
end
