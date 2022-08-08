# frozen_string_literal: true


module Petfinder
  module Apis
    module Pets

      def all_pets_from_api
        connect_to_api = connection
        response = connect_to_api.get('')
        puts "Failed to connect to the API. Response status: #{response.status}." if response.status != 200
        JSON.parse(response.body || {})['animals']
      end

      def write_to_db
        # write to the DB
      end

      def update
        # update records from the DB
      end

    end
  end
end