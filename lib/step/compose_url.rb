# frozen_string_literal: true

require 'u-case'

module Step
  URL = 'https://pokeapi.co/api/v2'
  class ComposeURL < Micro::Case
    attributes :entity, :name

    def call!
      Success { {url: "#{URL}/#{entity}/#{name}"} }
    end
  end
end
