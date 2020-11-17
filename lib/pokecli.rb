# frozen_string_literal: true

require 'pokecli/version'
require 'pokecli/cli'
require 'pokecli/get_entity_data'

module Pokecli
  class Error < StandardError; end
  module Utils
    Compose = lambda do |*funcs|
      lambda do |value|
        funcs.reduce(value) do |input, fn|
          fn.call(input)
        end
      end
    end
  end
end
