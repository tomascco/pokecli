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
      parsed_response = JSON.parse(response, symbolize_names: true)

      Success { parsed_response }
    end
  end
end
