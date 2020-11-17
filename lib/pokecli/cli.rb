# frozen_string_literal: true

require 'thor'

module Pokecli
  class CLI < Thor
    desc 'pokemon POKEMON', 'queries for an pokemon named POKEMON'
    def pokemon(*name_args)
      get_entity_data(entity: :pokemon, name_args: name_args)
    end

    desc 'ability ABILITY', 'queries for an ability named ABILITY'
    def ability(*name_args)
      get_entity_data(entity: :ability, name_args: name_args)
    end

    private

    def get_entity_data(entity:, name_args:)
      GetEntityData::Flow.call(entity: entity, name_args: name_args)
        .on_success { |result| puts result[:data] }
        .on_failure { puts 'Resource not found' }
    end
  end
end
