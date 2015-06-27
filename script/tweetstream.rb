require 'tweetstream'
ENV["RAILS_ENV"] ||= "development"

root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
require File.join(root, "config", "environment.rb")
TweetStream.configure do |config|
  config.consumer_key       = '1OUesoIo2HF6xSMVFL94omenM'
  config.consumer_secret    = 'bsWqZCUbXWP87JcWfFfbv2aWmCncqAUBXIjDRgAbFZQPtE1RIb'
  config.oauth_token        = '3189977174-ipQDTPrZpVzxDg2EluCFMIQNVOmbDxQuGm90JVu'
  config.oauth_token_secret = 'dEhlCO2tppyO3hTQkPeFGP0ou1DMhHYbksvwW9fk23YUd'
  config.auth_method        = :oauth
end

client = Twitter::REST::Client.new do |config|
    config.consumer_key = "1OUesoIo2HF6xSMVFL94omenM"
    config.consumer_secret = "bsWqZCUbXWP87JcWfFfbv2aWmCncqAUBXIjDRgAbFZQPtE1RIb"
    config.access_token = "3189977174-ipQDTPrZpVzxDg2EluCFMIQNVOmbDxQuGm90JVu"
    config.access_token_secret = "dEhlCO2tppyO3hTQkPeFGP0ou1DMhHYbksvwW9fk23YUd"
end

daemon = TweetStream::Daemon.new('tracker', :log_output => true)
daemon.on_inited do
  puts "Connected to Database."
  ActiveRecord::Base.connection.reconnect!
  puts "Connected"
end
daemon.track('@accioService', '@accioservice') do |tweet|
  puts tweet.text 
  service, zipcode = tweet.text.split.collect{|a| a if a.starts_with? '#'}.compact
  puts service
  puts zipcode
  TweetRequest.create!(:service => service.downcase.delete("#"), :zipcode => zipcode.delete("#zip"))
  providers = User.active.where(:zipcode => zipcode.delete("#zip")).select{|user| user.services.collect(&:name).collect(&:downcase).include? service.downcase.delete('#')}.first(3)
  if providers.blank?
    client.update("No active #{service.downcase.delete('#')} around #{zipcode} right now.")
  else
    client.update("Contact number(s) for #{service} around #{zipcode} : #{providers.collect(&:phone).join(", ")} ")
  end
end
