# frozen_string_literal: true

require 'u-case'
require 'pokecli/get_entity_data/step/format_params'
require 'pokecli/get_entity_data/step/compose_url'
require 'pokecli/get_entity_data/step/perform_request'
require 'pokecli/get_entity_data/step/format_output'

module Pokecli
  module GetEntityData
    Flow = Micro::Cases.flow([
      Step::FormatParams,
      Step::ComposeURL,
      Step::PerformRequest,
      Step::FormatOutput
    ])
  end
end
