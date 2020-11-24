# frozen_string_literal: true

require 'test_helper'

module Pokecli
  module GetEntityData
    class PokecliTest < Minitest::Test
      def test_that_it_has_a_version_number
        refute_nil VERSION
      end

      def test_format_params
        strings = [{entity: 'aBility', name_args: %w[Desolate Land]},
                   {entity: 'AbilitY', name_args: %w[dEsOLaTe land]},
                   {entity: 'AbIliTy', name_args: ['desolate-land']},
                   {entity: 'ability', name_args: %w[desolate land]},
                   {entity: 'ABILITY', name_args: %w[desolate land]}]

        results = strings.map(&FormatParams)

        results.each do |result|
          assert_equal({entity: 'ability', name: 'desolate-land'}, result.data)
        end
      end

      def test_perform_request
        success_body = File.new('test/snapshots/ability/request.txt')
        stub_request(:any, 'https://pokeapi.co/api/v2/ability/desolate-land')
          .to_return(body: success_body)

        success_result = PerformRequest.call(entity: :ability, name: 'desolate-land')

        assert_predicate(success_result, :success?)

        # --

        failure_body = 'Not Found'
        stub_request(:any, 'https://pokeapi.co/api/v2/ability/desolate-land')
          .to_return(body: failure_body)

        failure_result = PerformRequest.call(entity: :ability, name: 'desolate-land')

        assert_predicate(failure_result, :failure?)
      end

      def test_format_output
        ability_request = File.read('test/snapshots/ability/request.txt')
        ability_response = JSON.parse(ability_request, symbolize_names: true)
        ability_expected_output = File.read('test/snapshots/ability/output.txt')

        result = FormatOutput.call(response: ability_response, entity: :ability, name: 'desolate-land')

        assert_equal(ability_expected_output, result[:data])

        # --

        pokemon_request = File.read('test/snapshots/pokemon/request.txt')
        pokemon_response = JSON.parse(pokemon_request, symbolize_names: true)
        pokemon_expected_output = File.read('test/snapshots/pokemon/output.txt')

        result = FormatOutput.call(response: pokemon_response, entity: :pokemon, name: 'eevee')

        assert_equal(pokemon_expected_output, result[:data])
      end
    end
  end
end
