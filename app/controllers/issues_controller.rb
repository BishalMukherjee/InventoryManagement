class IssuesController < ApplicationController
  before_action :require_login

  def index
    @issues = Issue.includes(:item)
  end

  def new
    @issue = Issue.new
    @items = Item.all
  end

  def create
    @issue = Issue.new(issue_params)

    if @issue.save
      redirect_to issues_path
    else
      flash[:message] = @issue.errors.full_messages
      redirect_to new_issue_path
    end
  end

  def edit
    @issue = Issue.find(params[:id])
    @items = Item.all
  end

  def update
    @issue = Issue.find(params[:id])

    if @issue.update(issue_params)
      if @issue.status
        Notification.create(notifiable_name: @issue.item.name,  details: "is fixed.", urgency: "info")
      end
      redirect_to issues_path
    else
      flash[:message] = @issue.errors.full_messages
      redirect_to edit_issue_path(@issue)
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy
    redirect_to issues_path
  end

  private
  def issue_params
    params.require(:issue).permit(:item_id, :details, :status)
  end

  private
  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to root_path
    end
  end
end