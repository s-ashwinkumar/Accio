class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :type
  attr_accessible :active, :address1, :address2, :city, :latitude, :longitude, :mobile, :name, :phone, :state, :verified, :zipcode, :avatar
  has_many :user_services
  has_many :services, :through => :user_services
  has_many :notifications

  scope :active, where(:active => true)

  def details
    "<input type='hidden' id='provider_id' value='#{id}' /><br/>
    <span class='info_image'><center><img src='#{avatar.url(:medium)}' /></center></span><br/>
    <div id='show_more_text' class='verified-#{verified.to_s}'>
    <div class='bg'></div>
    <span class='pull-right'><strong>#{name}</strong></span><br/>
    <span class='pull-right'><strong>#{mobile}</strong></span><br/>
    <span class='pull-right'>#{phone}</span><br/>
    <span class='pull-right'>#{address1}</span><br/>
    <span class='pull-right'>#{address2}</span><br/>
    <span class='pull-right'>#{city} - #{zipcode}</span><br/>
    <span class='pull-left'><a href='#' onclick='openRequestCallbackForm();'>Request Callback</a></span>
    </div></div>"
  end

  def calc_distance(lat, lng)
    Math.sqrt(((lat.to_f-latitude.to_f)**2)+((lng.to_f-longitude.to_f)**2))
  end
end
