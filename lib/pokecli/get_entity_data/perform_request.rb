# frozen_string_literal: true

require 'net/http'
require 'json'

module Pokecli
  module GetEntityData
    class PerformRequest < Micro::Case
      attributes :url

      def call!
        uri = URI(url)
        response = Net::HTTP.get(uri)
        return Failure(:not_found) if response == 'Not Found'

        parsed_response = JSON.parse(response, symbolize_names: true)

        Success result: {response: parsed_response}
      end
    end
  end
end
