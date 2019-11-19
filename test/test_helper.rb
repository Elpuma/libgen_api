$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "libgen_api"
require "minitest/autorun"

# add default progress bar to reports
require 'minitest/reporters'

Minitest::Reporters.use!