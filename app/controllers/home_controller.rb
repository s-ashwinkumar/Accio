class HomeController < ApplicationController

  def index
    @services = Service.all
    if current_user
      redirect_to redirect_user and return
    end
  end

  def get_users
    service=Service.find_by_id(params[:service_id])
    users = service.users.active
    @hash = Gmaps4rails.build_markers(users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow "<div class='infobox_details'><IMG BORDER='0' ALIGN='Left' SRC='https://www.google.co.in/logos/doodles/2015/nellie-blys-151st-birthday-4862371034038272-res.png' style='height:80px;width:80px'><b>#{user.name}</b><br/>#{user.phone}<br/>#{user.mobile}<br/><a href='#' onclick='showMore(#{user.id})'>Show More...</a></div>"
    end
    render :json => @hash.to_json
  end

  def user_data
    user = User.find(params[:user_id])
    render :text => user.details
  end

  def request_callback
      Notification.create!({
      user_id: params[:user_id],
      service_id: params[:service_id],
      requestor_name: params[:requestor_name],
      requestor_phone: params[:requestor_phone],
      requestor_message: params[:requestor_message]
      })
      user = User.find_by_id(params[:user_id])
      service = Service.find_by_id(params[:service_id])
      NotificationMailer.notify(user.email,"Hey, #{params[:requestor_name]} is waiting for you !!!

More Details:
      Name: #{params[:requestor_name]}
      Phone: #{params[:requestor_phone]}
      Service: #{service.name}
      Message: #{params[:requestor_message]}

With Regards,
Accio Team.")
      render :text => "True"
  end

  def help_me
    lat = params[:lat]
    lng=params[:lng]
    service_id=params[:service_id]
    requestor_name = params[:requestor_name],
    requestor_phone = params[:requestor_phone],
    requestor_message = params[:requestor_message]
    service = Service.find_by_id(params[:service_id])
    users_in_range = User.active.where("latitude between '#{lat.to_f-0.05}' and '#{lat.to_f+0.05}' and longitude between '#{lng.to_f-0.05}' and '#{lng.to_f+0.05}'" ).select{|u| u.services.include?(service)}
    nearest_users = users_in_range.sort_by{|user| user.calc_distance(lat,lng)}[0..3]
    group_id=`uuidgen`
    nearest_users.each do |user|
      Notification.create!({
      user_id: user.id,
      service_id: service_id,
      requestor_name: requestor_name,
      requestor_phone: requestor_phone,
      requestor_message: requestor_message,
      group_id: group_id
      })
    end
    NotificationMailer.notify(nearest_users.collect(&:email),"Hey, #{params[:requestor_name]} has requested help !!!

More Details:
      Name: #{params[:requestor_name]}
      Phone: #{params[:requestor_phone]}
      Service: #{service.name}
      Message: #{params[:requestor_message]}

With Regards,
Accio Team.") if nearest_users.present?
    render json: nearest_users.map { |user| {name: user.name, mobile: user.mobile} }
  end

end
