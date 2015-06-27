class NotificationController < ApplicationController
  
  def deactivate
    Notification.find_by_id(params[:id]).deactivate
    render :text => "success"
  end
end
