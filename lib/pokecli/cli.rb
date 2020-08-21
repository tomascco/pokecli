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
    
    desc 'query ENTITY NAME', 'queries for an entity named NAME'
    def query(entity, *name_args)
      p GetEntityData.({entity: entity, name_args: name_args})
                     .value
    end
  end
end
