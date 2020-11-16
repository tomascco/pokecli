# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'pokecli/get_entity_data'

require 'minitest/autorun'
require 'minitest/pride'
require 'webmock/minitest'
