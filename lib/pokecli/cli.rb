# frozen_string_literal: true

require 'thor'

module Pokecli
  class CLI < Thor
    desc 'pokemon POKEMON', 'queries for an pokemon named POKEMON'
    def pokemon(*name_args)
      result = 
        GetEntityData::Flow.call(entity: :pokemon, name_args: name_args)

      puts result[:data]
    end

    desc 'ability ABILITY', 'queries for an ability named ABILITY'
    def ability(*name_args)
      result =
        GetEntityData::Flow.call(entity: :ability, name_args: name_args)

      puts result[:data]
    end
  end
end
