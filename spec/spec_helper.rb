$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

MODELS = File.join(File.dirname(__FILE__), "app/models")
$LOAD_PATH.unshift(MODELS)

require 'salesforce'

Dir[ File.join(MODELS, "*.rb") ].sort.each { |file| require File.basename(file) }

RSpec.configure do |config|
end
