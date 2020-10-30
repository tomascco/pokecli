# frozen_string_literal: true

require 'u-case'

module Step
  class FormatOutput < Micro::Case
    attributes :response, :entity

    def call!
      Success result: {data: method(entity).call}
    end

    def pokemon
    end

    def ability
      effect_entries = response[:effect_entries].find { |effect| effect.dig(:language, :name) == 'en' }

      pokemon = response[:pokemon].map { |ability| ability.dig(:pokemon, :name) }
    end
  end
end
