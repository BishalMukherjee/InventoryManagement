class AdminsController < ApplicationController
  before_action :require_login

  def index
    @admins = Admin.all
  end

  def new
    if current_user && current_user.admin_access
      @admin = Admin.new
    else
      redirect_to root_path
    end
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to admins_path
    else
      flash[:message] = @admin.errors.full_messages
      redirect_to new_admin_path
    end
  end

  def edit
    if current_user && current_user.admin_access
      @admin = Admin.find(params[:id])
    else
      redirect_to items_path
    end
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update(admin_params)
      redirect_to admins_path
    else
      flash[:message] = @admin.errors.full_messages
      redirect_to edit_admin_path(@admin)
    end
  end

  def destroy
    if current_user && current_user.admin_access
      @admin = Admin.find(params[:id])

      unless current_user == @admin
        @admin.destroy
        redirect_to admins_path
      else
        redirect_to admins_path, notice: "You can't delete yourself!"
      end  
    else
      redirect_to root_path
    end
  end

  private
  def admin_params
    params.require(:admin).permit(:name, :email, :category_access, :brand_access, :item_access, :employee_access, :storage_access)
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access admin section"
      redirect_to root_path
    end
  end
end