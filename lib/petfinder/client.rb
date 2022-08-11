# frozen_string_literal: true

require_relative 'connection'
require_relative 'constants'
require_relative 'apis/pets'
require 'faraday'

module Petfinder
  class Client
    include(::Petfinder::Connection)
    include(::Petfinder::Constants)
    include(::Petfinder::Apis::Pets)

    attr_reader(:client_id, :client_secret)

    def initialize(client_id:, client_secret:)
      raise Exception, 'Please ensure credentials are correct.' if client_id.empty? || client_secret.empty?

      @client_id = client_id
      @client_secret = client_secret
    end
  end
end