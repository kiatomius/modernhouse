require_relative "./modernhouse/version"
require_relative './modernhouse/cli'
require_relative './modernhouse/house'

require 'open-uri'
require 'nokogiri'
require 'pry'

module Modernhouse
  class Error < StandardError; end
  # Your code goes here...
end
