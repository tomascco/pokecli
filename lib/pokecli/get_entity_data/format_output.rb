# frozen_string_literal: true

module Pokecli
  module GetEntityData
    class FormatOutput < Micro::Case
      attributes :response, :entity, :name
      Unslugify = ->name { name.tr('-', ' ').capitalize }
      StatFormatter = ->stat { "#{stat[0].capitalize}: #{stat[1]}" }

      def call!
        Success result: {data: method(entity).call}
      end

      private

      def pokemon
        learned_abilities = response[:abilities].map { |ability| ability.dig(:ability, :name) }
        pokedex_number = response[:id]
        base_stats = response[:stats].map { |stat| [stat.dig(:stat, :name), stat[:base_stat]] }
        types = response[:types].map { |type| type.dig(:type, :name) }

        <<~POKEMON
          Pokemon: #{Unslugify.call(name)} (N° #{pokedex_number})
          Types: #{types.map(&:capitalize).join('/')}
          Abilities: #{learned_abilities.map(&Unslugify).join(', ')}

          Base stats:
          #{base_stats.map(&StatFormatter).join("\n")}
        POKEMON
      end

      def ability
        effect = response[:effect_entries]
          .find { |effect_object| effect_object.dig(:language, :name) == 'en' }
          .fetch(:effect)
        learning_pokemon = response[:pokemon]
          .map(&Utils::Compose[->ability { ability.dig(:pokemon, :name) }, Unslugify])
          .join("\n")

        <<~POKEMON
          Ability: #{Unslugify.call(name)}
          Effect in battle: #{effect}

          Pokemon that learn this ability:
          #{learning_pokemon}
        POKEMON
      end

      private_constant :Unslugify, :StatFormatter
    end
  end
end
