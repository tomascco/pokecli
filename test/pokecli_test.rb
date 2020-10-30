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

    result = Step::ComposeURL.call(params)

    assert_equal('https://pokeapi.co/api/v2/ability/desolate-land', result[:url])
  end

  def test_perform_request
    success_body = File.new('test/request.txt')
    stub_request(:any, 'https://pokeapi.co/api/v2/ability/desolate-land')
      .to_return(body: success_body)

    success_result = Step::PerformRequest.call(url: 'https://pokeapi.co/api/v2/ability/desolate-land')

    assert(success_result.success?)

    # --

    failure_body = 'Not Found'
    stub_request(:any, 'https://pokeapi.co/api/v2/ability/desolate-land')
      .to_return(body: failure_body)

    failure_result = Step::PerformRequest.call(url: 'https://pokeapi.co/api/v2/ability/desolate-land')

    assert(failure_result.failure?)
  end

  def test_format_output
    response = File.read('test/request.txt')
    response_hash = JSON.parse(response, symbolize_names: true)
    expected_output = File.read('test/output.txt')

    result = Step::FormatOutput
      .call(response: response_hash, entity: :ability, name: 'desolate-land')

    assert_equal(expected_output, result[:data])
  end
end
