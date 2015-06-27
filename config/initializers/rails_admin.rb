# RailsAdmin config file. Generated on May 09, 2015 11:18
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|


  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Accio', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  config.authorize_with do |controller|
    unless current_user.is_a?(Admin)
      flash[:error] = "You are not an admin"
      redirect_to main_app.user_path
    end
  end
  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, 'User'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'User'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  # config.excluded_models = ['UserService']

  # Include specific models (exclude the others):
  config.included_models = ['Service', 'Provider','Admin']

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]
end
