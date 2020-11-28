# frozen_string_literal: true

module Pokecli::EntityFormatters
  module Pokemon
    FormatStat = ->(stat) { "#{stat[0].capitalize}: #{stat[1]}" }
    GetTypeNames = ->(types) { types.map(&->(type) { type.dig(:type, :name).capitalize }).join('/') }

    GetBaseStats = ->(stats) do
      stats.map(&->(stat) { [stat.dig(:stat, :name), stat[:base_stat]] } >> FormatStat).join("\n")
    end

    GetLearnedAbilities = ->(abilities) do
      abilities.map(&->(ability) { ability.dig(:ability, :name) } >> Unslugify).join(', ')
    end

    GetParams = ->(id:, abilities:, stats:, types:, name:, **) do
      {
        name: Unslugify[name],
        types: GetTypeNames[types],
        base_stats: GetBaseStats[stats],
        pokedex_number: id,
        learned_abilities: GetLearnedAbilities[abilities]
      }
    end

    TEMPLATE = <<~POKEMON
      Pokemon: %{name} (N° %{pokedex_number})
      Types: %{types}
      Abilities: %{learned_abilities}

      Base stats:
      %{base_stats}
    POKEMON

    def self.call(response)
      TEMPLATE % GetParams[**response]
    end

    private_constant :FormatStat, :GetTypeNames, :GetBaseStats, :GetLearnedAbilities, :GetParams
  end
end
