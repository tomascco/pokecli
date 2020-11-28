# frozen_string_literal: true

module Pokecli
  class GetEntityData::FormatOutput < Micro::Case
    attributes :response, :entity

    def call!
      formatter = EntityFormatters::MAP.fetch(entity)

      Success result: {data: formatter.call(response)}
    end
  end
end
