class ItemsController < ApplicationController
  before_action :require_login

  def index
    @items = Item.includes(:employee, :brand)
  end

  def new
    if current_user && current_user.item_access
      @item = Item.new
      @brands = Brand.all
      @employees = Employee.all
    else
      redirect_to root_path
    end
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to items_path
    else
      flash[:message] = @item.errors.full_messages
      redirect_to new_item_path
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def document
    unless Item.find(params[:id]).document.blank?
      @document = Item.find(params[:id]).document
      send_file(@document.path,
                disposition: "attachment",
                url_based_filename: false)
    else
      redirect_to items_path
    end
  end

  def edit
    if current_user && current_user.item_access
      @employees = Employee.all
      @brands = Brand.all
      @item = Item.find(params[:id])
    else
      redirect_to items_path
    end
  end

  def update 
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to items_path
    else
      flash[:message] = @item.errors.full_messages
      redirect_to edit_item_path(@item)
    end
  end

  def destroy
    if current_user && current_user.item_access
      @item = Item.find(params[:id])

      if @item.employee_id.nil?
        @item.destroy
        redirect_to items_path
      else
        redirect_to items_path, notice: "This item can't be deleted. It is assigned to an employee."
      end  
    else
      redirect_to items_path
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :notes, :brand_id, :status, :document, :employee_id)
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access item section"
      redirect_to root_path
    end
  end
end