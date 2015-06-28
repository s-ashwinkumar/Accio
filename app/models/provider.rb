class Provider < User
  # Methods, variables and constants
  has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  rails_admin do
    list do
      field :name
      field :active
      field :verified
      field :email
      field :zipcode
    end
    edit do
      field :name
      field :email
      field :active
      field :verified
      field :zipcode
      field :password
    end
  end

end