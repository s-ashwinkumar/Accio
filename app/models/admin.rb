class Admin < User
  # Methods, variables and constants
  rails_admin do
    list do
      field :name
      field :email
    end
    edit do
      field :name
      field :email
      field :password
    end
  end
end