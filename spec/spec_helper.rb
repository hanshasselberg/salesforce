$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'salesforce'

Salesforce.configure do |config|
  config.username = 'hans.hasselberg@googmail.com'

end

RSpec.configure do |config|
end
