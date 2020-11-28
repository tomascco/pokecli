# frozen_string_literal: true

require 'pokecli/entity_formatters/pokemon'
require 'pokecli/entity_formatters/ability'
require 'pokecli/entity_formatters/move'

module Pokecli::EntityFormatters
  MAP = {
    pokemon: Pokemon,
    ability: Ability,
    move: Move
  }.freeze

  Unslugify = ->(name) { name.tr('-', ' ').capitalize }
end
