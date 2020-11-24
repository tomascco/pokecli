# frozen_string_literal: true

require 'u-case'
require 'pokecli/get_entity_data/format_params'
require 'pokecli/get_entity_data/perform_request'
require 'pokecli/get_entity_data/format_output'

module Pokecli
  module GetEntityData
    Flow = Micro::Cases.flow([
      FormatParams,
      PerformRequest,
      FormatOutput
    ])
    BASE_URL = 'https://pokeapi.co/api/v2'
    BuildURL = ->entity, name { "#{BASE_URL}/#{entity}/#{name}" }
  end
end
