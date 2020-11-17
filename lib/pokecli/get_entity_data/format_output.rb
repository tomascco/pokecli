# frozen_string_literal: true

module Pokecli
  module GetEntityData
    class FormatOutput < Micro::Case
      attributes :response, :entity, :name
      Unslugify = ->name { name.tr('-', ' ').capitalize }

      def call!
        Success result: {data: method(entity).call}
      end

      private

      def pokemon; end

      def ability
        effect = response[:effect_entries]
          .find { |effect_object| effect_object.dig(:language, :name) == 'en' }
          .fetch(:effect)
        learning_pokemon = response[:pokemon]
          .map(&->ability { ability.dig(:pokemon, :name) } >> Unslugify)
          .join("\n")

        <<~POKEMON
          Ability: #{Unslugify.call(name)}
          Effect in battle: #{effect}

          Pokemon that learn this ability:
          #{learning_pokemon}
        POKEMON
      end
    end
  end
end
