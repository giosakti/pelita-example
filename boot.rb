# Load root app
require_relative 'config/application'

# Boot sub-apps
app_paths = Pathname(__FILE__).dirname.join("apps").realpath.join("*")
Dir[app_paths].each { |f| require "#{f}/boot" }
