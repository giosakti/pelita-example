require 'bundler/setup'
Bundler.require

# Load environment variables
require 'dotenv/load'

# Load root app
require_relative 'application'

# Boot sub apps
app_paths = Pathname(__FILE__).dirname.join("../apps").realpath.join("*")
Dir[app_paths].each { |f| require "#{f}/system/boot" }
