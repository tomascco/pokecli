# frozen_string_literal: true

require 'u-case'
require 'net/http'
require 'json'

module Step
  class PerformRequest < Micro::Case
    attributes :url

    def call!
      uri = URI(url)
      response = Net::HTTP.get(uri)
      return Failure(:not_found) { 'The resource was not found.' } if response == 'Not Found'

      parsed_response = JSON.parse(response, symbolize_names: true)

      Success result: {response: parsed_response}
    end
  end
end
