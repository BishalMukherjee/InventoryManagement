class StoragesController < ApplicationController
  before_action :require_login

  def index
    @storages = Storage.includes(:category)
  end

  def new
    if current_user && current_user.storage_access
      @storage = Storage.new
      @categories = Category.all
    else
      redirect_to storages_path
    end
  end

  def create
    @storage = Storage.new(storage_params)

    if @storage.save
      redirect_to storages_path
    else
      flash[:message] = @storage.errors.full_messages
      redirect_to new_storage_path
    end
  end

  def edit
    if current_user && current_user.storage_access
      @storage = Storage.find(params[:id])
      @categories = Category.all
    else
      redirect_to storages_path
    end
  end

  def update
    @storage = Storage.find(params[:id])

    if @storage.update(storage_params)
      redirect_to storages_path
    else
      flash[:message] = @storage.errors.full_messages
      redirect_to edit_storage_path(@storage)
    end
  end

  def destroy
    if current_user && current_user.storage_access
      @storage = Storage.find(params[:id])
      associated = @storage.category.items.count

      if associated > 0
        redirect_to storages_path, notice: "This storage details can't be deleted. Items are available in Item section."
      else
        @storage.destroy
        redirect_to storages_path
      end
    else
      redirect_to storages_path
    end
  end

  private
  def storage_params
    params.require(:storage).permit(:category_id, :total, :buffer, :procurement_time)
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access storage section"
      redirect_to root_path
    end
  end
end