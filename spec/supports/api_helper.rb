
module ApiHelper
  include Rack::Test::Methods

  def app
    Rails.application
  end

  def set_json
   {'HTTP_ACCEPT' => 'application/json', 'CONTENT_TYPE'=> 'application/json'}
  end
end
