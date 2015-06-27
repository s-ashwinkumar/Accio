class Service < ActiveRecord::Base
  attr_accessible :active, :name
  has_many :user_services
  has_many :users, :through => :user_services
  has_many :notifications
end
