# frozen_string_literal: true

require 'thor'

module Pokecli
  class CLI < Thor
    desc 'ENTITY NAME', 'queries for an entity named NAME'
    def query(entity, *name_args)
    end
  end
end
