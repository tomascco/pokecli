# frozen_string_literal: true

require 'pokecli/get_entity_data/format_output/ability'
require 'pokecli/get_entity_data/format_output/pokemon'
require 'pokecli/get_entity_data/format_output/move'

module Pokecli
  module GetEntityData
    class FormatOutput < Micro::Case
      attributes :response, :entity

      FORMATTER_MAP = {
        pokemon: Pokemon,
        entity: Entity,
        move: Move
      }.freeze

      def call!
        call(FORMATTER_MAP.fetch(entity), response)
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
