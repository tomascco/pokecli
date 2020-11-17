# frozen_string_literal: true

module Pokecli
  module GetEntityData
    BASE_URL = 'https://pokeapi.co/api/v2'
    class ComposeURL < Micro::Case
      attributes :entity, :name

      def call!
        Success result: {url: "#{BASE_URL}/#{entity}/#{name}"}
      end
    end
  end
end
