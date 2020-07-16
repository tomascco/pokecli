# frozen_string_literal: true

require 'thor'
require 'pokecli'

module Pokecli
  class CLI < Thor
    
    desc 'query ENTITY NAME', 'queries for an entity named NAME'
    def query(entity, *name_args)
      p Step::FormatParams.({entity: entity, name_args: name_args})
          .then(Step::ComposeURL)
          .then(Step::PerformRequest)
          .value
    end
  end
end
