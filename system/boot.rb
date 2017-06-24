require 'bundler/setup'
Bundler.require

require_relative 'container'
RopExample::Container.finalize!

# Load root app
require_relative 'application'

# Boot sub-apps
app_paths = Pathname(__FILE__).dirname.join("../apps").realpath.join("*")
Dir[app_paths].each { |f| require "#{f}/system/boot" }
