# frozen_string_literal: true

module Pokecli::EntityFormatters
  module Ability
    GetEffect = ->(effect_entries) do
      effect_entries.find { |effect| effect.dig(:language, :name) == 'en' }.fetch(:effect)
    end

    GetLearningPokemon = ->(pokemon) do
      pokemon.map(&->(ability) { ability.dig(:pokemon, :name) } >> Unslugify).join("\n")
    end

    GetParams = ->(name:, effect_entries:, pokemon:, **) do
      {
        name: Unslugify[name],
        effect_entries: GetEffect[effect_entries],
        learning_pokemon: GetLearningPokemon[pokemon]
      }
    end

    TEMPLATE = <<~POKEMON
      Ability: %{name}
      Effect in battle: %{effect_entries}

      Pokemon that learn this ability:
      %{learning_pokemon}
    POKEMON

    def self.call(response)
      TEMPLATE % GetParams[**response]
    end
  end
end
