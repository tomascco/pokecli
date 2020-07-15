# frozen_string_literal: true

require 'test_helper'

class PokecliTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Pokecli::VERSION
  end

  def test_format_params
    strings = [{entity: 'aBility', name_args: %w[Desolate Land]},
               {entity: 'AbilitY', name_args: %w[dEsOLaTe land]},
               {entity: 'AbIliTy', name_args: ['desolate-land']},
               {entity: 'ability', name_args: %w[desolate land]},
               {entity: 'ABILITY', name_args: %w[desolate land]}]

    params_results = strings.map(&Step::FormatParams)
    params_values = params_results.map(&:value)

    params_values.each do |param|
      assert_equal({entity: 'ability', name: 'desolate-land'}, param)
    end
  end

  def test_compose_url
    params = {entity: 'ability', name: 'desolate-land'}

    url = Step::ComposeURL.(params: params)

    assert_equal 'https://pokeapi.co/api/v2/ability/desolate-land', url.value
  end
end
