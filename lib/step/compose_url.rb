# frozen_string_literal: true

require 'u-case'

module Step
  URL = 'https://pokeapi.co/api/v2'
  class ComposeURL < Micro::Case
    attributes :params

    def call!
      Success { "#{URL}/#{params[:entity]}/#{params[:name]}" }
    end
  end
end
