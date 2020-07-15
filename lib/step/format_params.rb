# frozen_string_literal: true
require 'u-case'

module Step
  class FormatParams < Micro::Case
    attributes :entity, :name_args

    def call!
      formatted_entity = entity.downcase
      formatted_name = name_args.join('-')
                                .downcase

      Success { {entity: formatted_entity, name: formatted_name} }
    end
  end
end
