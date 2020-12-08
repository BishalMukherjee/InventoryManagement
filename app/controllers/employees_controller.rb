class EmployeesController < ApplicationController
  before_action :require_login
  
  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
    @items = @employee.items
  end

  def new
    if current_user && current_user.employee_access
      @employee = Employee.new
    else
      redirect_to employees_path
    end
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      redirect_to employees_path
    else
      flash[:message] = @employee.errors.full_messages
      redirect_to new_employee_path
    end
  end

  def edit
    if current_user && current_user.employee_access
      @employee = Employee.find(params[:id])
    else
      redirect_to employees_path
    end
  end

  def update
    @employee = Employee.find(params[:id])

    if @employee.update(employee_params)
      redirect_to employees_path
    else
      flash[:message] = @employee.errors.full_messages
      redirect_to edit_employee_path(@employee)
    end
  end

  def destroy
    if current_user && current_user.employee_access
      @employee = Employee.find(params[:id])

      if @employee.items.blank?
        unless @employee.status
          @employee.destroy
          redirect_to employees_path
        else
          redirect_to employees_path, notice: "Working employee can't be deleted."
        end
      else
        redirect_to employees_path, notice: "The employee can't be deleted. Items are associated with this employee."
      end
    else
      redirect_to employees_path
    end
  end

  private
  def employee_params
    params.require(:employee).permit(:name, :email, :status)
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access employee section"
      redirect_to root_path
    end
  end
end