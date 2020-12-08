class BrandsController < ApplicationController
  before_action :require_login

  def index
    @brands = Brand.includes(:category).all
  end

  def new
    if current_user && current_user.brand_access
      @brand = Brand.new
      @categories = Category.all
    else
      redirect_to brands_path
    end
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      redirect_to brands_path
    else
      flash[:message] = @brand.errors.full_messages
      redirect_to new_brand_path
    end
  end

  def destroy
    if current_user && current_user.brand_access
      @brand = Brand.find(params[:id])
      if @brand.items.blank?
        @brand.destroy
        redirect_to brands_path
      else
        redirect_to brands_path, notice: "Some items belong to this brand. Can't be deleted."
      end
    else
      redirect_to brands_path
    end
  end

  private

  def brand_params
    params.require(:brand).permit(:name, :category_id)
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access brand section"
      redirect_to root_path
    end
  end
end