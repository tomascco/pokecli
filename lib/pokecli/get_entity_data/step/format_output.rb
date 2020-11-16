# frozen_string_literal: true

module Pokecli
  module GetEntityData
    module Step
      class FormatOutput < Micro::Case
        attributes :response, :entity, :name
        PrettifyName = ->(name) { name.tr('-', ' ').capitalize }

        def call!
          Success result: {data: method(entity).call}
        end

        private

        def pokemon
        end

        def ability
          effect = response[:effect_entries]
            .find { |effect_object| effect_object.dig(:language, :name) == 'en' }
            .fetch(:effect)
          learning_pokemon = response[:pokemon]
            .map { |ability| PrettifyName.call(ability.dig(:pokemon, :name)) }
            .join("\n")

          <<~POKEMON
            Ability: #{PrettifyName.call(name)}
            Effect in battle: #{effect}

            Pokemon that learn this ability:
            #{learning_pokemon}
          POKEMON
        end
      end
    end
  end
end
