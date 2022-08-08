# frozen_string_literal: true


module Petfinder
  module Constants
    API_ENDPOINT = ENV.fetch('API_ENDPOINT', 'https://api.petfinder.com/v2/animals')
  end
end