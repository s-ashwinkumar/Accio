class UserController < ApplicationController
  layout 'provider'
  def index
    @user = current_user
  end

  def sign_in
    redirect_to root_path
  end

  def notifications
    @group_notifs = current_user.notifications.active.grouped
    @indi_notifs = current_user.notifications.active.individual
  end

  def update
    begin
      if user = User.find_by_id(params[:id])
        user.update_attributes params[:provider].except("service_ids")
        user.services = Service.find_all_by_id(params[:provider]["service_ids"])
        user.save!
        flash[:success] = "Updated Successfully"
      end
    rescue Exception => e
      flash[:error] = e.message
    end
    redirect_to user_path
  end

  def services
    @services ||= Service.all
  end

  helper_method :services
end
