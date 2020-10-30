# frozen_string_literal: true

require 'thor'
require 'pokecli'

module Pokecli
  GetEntityData = Micro::Cases.flow([
    Step::FormatParams,
    Step::ComposeURL,
    Step::PerformRequest
  ])
  class CLI < Thor
    desc 'pokemon POKEMON', 'queries for an pokemon named POKEMON'
    def pokemon(*name_args)
      p GetEntityData.call({entity: :pokemon, name_args: name_args})
        .then(Step::FormatOutput)
    end

    desc 'ability ABILITY', 'queries for an ability named ABILITY'
    def ability(*name_args)
      result = GetEntityData.call({entity: :ability, name_args: name_args})
        .then(Step::FormatOutput)
      puts(result[:data])
    end
  end
end
