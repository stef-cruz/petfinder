# frozen_string_literal: true


module Petfinder
  module Connection
    def access_token
      conn = Faraday.new(url: 'https://api.petfinder.com/v2/oauth2/token',
                         headers: { 'Content-Type' => 'application/json' }) do |faraday|
        faraday.response(:logger, ::Logger.new($stdout), bodies: true)
      end

      response = conn.post('') do |req|
        req.body = {
          client_id: client_id,
          client_secret: client_secret,
          grant_type: 'client_credentials',
        }.to_json
      end
      response_body = JSON.parse(response&.body || {})
      response_body['access_token']
    end

    def connection
      jwt_token = access_token
      Faraday.new(url: ::Petfinder::Constants::API_ENDPOINT.to_s,
                  headers: { 'Content-Type' => 'application/json',
                             'Authorization' => "Bearer #{jwt_token}" }) do |faraday|
        faraday.response(:logger, ::Logger.new($stdout), bodies: true)
      end
    end
  end
end