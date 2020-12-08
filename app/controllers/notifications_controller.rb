class NotificationsController < ApplicationController
  before_action :require_login

  def index
    @notifications_all = Notification.all
    @notifications = Notification.unread_notification
  end

  def mark_as_read
    @notifications = Notification.unread_notification
    @notifications.update_all(read_status: true)
    render json: { success: true }
  end

  def destroy
    if current_user && current_user.admin_access
      @notification = Notification.find(params[:id])
      @notification.destroy
      redirect_to notifications_path
    else
      redirect_to root_path
    end
  end

  def clear_table
    if current_user && current_user.admin_access
      @notifications = Notification.all
      @notifications.destroy_all
      redirect_to notifications_path
    else
      redirect_to root_path
    end
  end

  private
  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access notification section"
      redirect_to root_path
    end
  end
end