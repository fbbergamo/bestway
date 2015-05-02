Apipie.configure do |config|
  config.app_name                = "BestWay"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"
  config.validate                = false
  config.show_all_examples       = true
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
