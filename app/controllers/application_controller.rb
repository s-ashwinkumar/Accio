class ApplicationController < ActionController::Base
  protect_from_forgery
  def after_sign_in_path_for(resource)
  	session[:user_id] = resource.id
    session["resource_return_to"] = redirect_user
  end

  def redirect_user
    current_user.is_a?(Provider) ? "/user" : "/admin"
  end

  def search
  	service ,zipcode = get_params(params[:text])
  	providers = User.where(:zipcode => zipcode).select{|user| user.services.collect(&:name).collect(&:downcase).include? service}.first(3)
  	res = if providers.blank?
    	"No active #{service.downcase.delete('#')} around #{zipcode} right now."
  	else
    	"Contact number(s) for #{service} around #{zipcode} : #{providers.collect(&:phone).join(", ")} "
  	end
  	render :text => res
  end

  def get_params(text)
  	service = ""
  	res = AlchemyAPI.search(:keyword_extraction, text: text)
  	if res.size > 0
  		services = Service.all.collect(&:name).map(&:downcase)
  		service =  res.collect{|ser| ser["text"] if services.include?(ser["text"]) }.compact.first
  	end
  	zip = text.split(" ").select{|asd| asd[0] == "@"}.first[1..-1].to_i
  	[service,zip]
  end
end
