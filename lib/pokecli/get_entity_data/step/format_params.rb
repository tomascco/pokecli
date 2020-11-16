# frozen_string_literal: true

module Pokecli
  module GetEntityData
    module Step
      class FormatParams < Micro::Case
        attributes :entity, :name_args

        def call!
          formatted_entity = entity.downcase
          formatted_name = name_args.join('-').downcase

          Success result: {entity: formatted_entity, name: formatted_name}
        end
      end
    end
  end
end
