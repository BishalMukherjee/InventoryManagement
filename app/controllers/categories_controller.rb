class CategoriesController < ApplicationController
  before_action :require_login

  def index
    @categories = Category.all
  end

  def new
    if current_user && current_user.category_access
      @category = Category.new
    else
      redirect_to categories_path
    end
  end
  
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path
    else
      flash[:message] = @category.errors.full_messages
      redirect_to new_category_path
    end
  end

  def destroy
    if current_user && current_user.category_access
      @category = Category.find(params[:id])
      if @category.brands.blank? && @category.storage.blank?
        @category.destroy
        redirect_to categories_path
      else
        redirect_to categories_path, notice: "Some brands and/or storage details belong to this category. Can't be deleted."
      end
    else
      redirect_to categories_path
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access category section"
      redirect_to root_path
    end
  end
end
