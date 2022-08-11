# frozen_string_literal: true

module Petfinder
  class Error < StandardError; end
  # Your code goes here...
  autoload :Constants, 'petfinder/constants'
  autoload :Pets, 'petfinder/apis/pets'
  autoload :Connection, 'petfinder/connection'
end
