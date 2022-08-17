# frozen_string_literal: true


require 'spec_helper'
require './lib/petfinder/client'
require 'byebug'

RSpec.describe(::Petfinder::Client) do
  let(:client_id) { 'ID/abcdefghij' }
  let(:client_secret) { 'SECRET/abcdefghij' }
  let(:access_token) { 'TOKEN/abcdefghij' }
  let(:argument_file) { 'spec/fixtures/data_sample.json' }
  let(:expected_body) { JSON.parse(File.read(argument_file)) }

  let(:response_200) do
    {
      success: true,
      code: 200,
      error: nil,
      access_token: access_token
    }.to_json
  end

  let(:response_401) do
    {
      success: false,
      code: 401,
      error: 'Access denied'
    }.to_json
  end

  describe('Test #initialize') do
    subject(:client) { described_class.new(client_id: client_id, client_secret: client_secret) }
    subject(:client_missing_credentials) { described_class.new(client_id: '', client_secret: '') }

    before do
      stub_request(:post, "https://api.petfinder.com/v2/oauth2/token").
        with(
          body: "{\"client_id\":\"ID/abcdefghij\",\"client_secret\":\"SECRET/abcdefghij\",\"grant_type\":\"client_credentials\"}",
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'=>'application/json'
          }).
        to_return(status: 200, body: response_200, headers: {})
    end

    it('sets initial values') do
      expect(client.client_id).to eq(client_id)
      expect(client.client_secret).to eq(client_secret)
    end

    it('missing credentials') do
      expect { client_missing_credentials }.to raise_error('Please ensure credentials are correct.')
    end
  end

  describe('Test #all_pets - Successfully fetching data from API') do
    subject(:client) { described_class.new(client_id: client_id, client_secret: client_secret) }

    before do
      stub_request(:post, "https://api.petfinder.com/v2/oauth2/token").
        with(
          body: "{\"client_id\":\"ID/abcdefghij\",\"client_secret\":\"SECRET/abcdefghij\",\"grant_type\":\"client_credentials\"}",
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'=>'application/json'
          }).
        to_return(status: 200, body: response_200, headers: {})

      stub_request(:get, "https://api.petfinder.com/v2/animals").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Bearer TOKEN/abcdefghij',
            'Content-Type'=>'application/json'
          }).
        to_return(status: 200, body: File.read(argument_file), headers: {})
    end

    it('Get data from the API') do
      response = client.all_pets
      expect(response.length).to be > 0
    end
  end

  describe('Test #all_pets - Failing to fetch data from API') do
    subject(:client) { described_class.new(client_id: client_id, client_secret: client_secret) }

    before do
      stub_request(:post, "https://api.petfinder.com/v2/oauth2/token").
        with(
          body: "{\"client_id\":\"ID/abcdefghij\",\"client_secret\":\"SECRET/abcdefghij\",\"grant_type\":\"client_credentials\"}",
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'=>'application/json'
          }).
        to_return(status: 200, body: response_200, headers: {})

      stub_request(:get, "https://api.petfinder.com/v2/animals").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Bearer TOKEN/abcdefghij',
            'Content-Type'=>'application/json'
          }).
        to_return(status: 401, body: response_401, headers: {})
    end

    it('Fail to get data from the API') do
      response = client.all_pets
      expect(response).to be nil
    end
  end

  describe('Test #pet_by_id - Successful') do
    subject(:client) { described_class.new(client_id: client_id, client_secret: client_secret) }

    let(:response_pet_by_id) do
      JSON.generate(
        {
          success: true,
          code: 200,
          "animal": [
            {
              "id": 56611192
            }
          ]
        }
      )
    end

    before do
      stub_request(:post, "https://api.petfinder.com/v2/oauth2/token").
        with(
          body: "{\"client_id\":\"ID/abcdefghij\",\"client_secret\":\"SECRET/abcdefghij\",\"grant_type\":\"client_credentials\"}",
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'=>'application/json'
          }).
        to_return(status: 200, body: response_200, headers: {})

      stub_request(:get, "https://api.petfinder.com/v2/animals/56611192").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Bearer TOKEN/abcdefghij',
            'Content-Type'=>'application/json'
          }).
        to_return(status: 200, body: response_pet_by_id, headers: {})
    end

    it('Get pet by id') do
      response = client.pet_by_id(56611192)
      expect(response[0]['id']).to be(56611192)
    end
  end
end
