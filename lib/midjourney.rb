require "faraday"
require "faraday/multipart"

require_relative "midjourney/http"
require_relative "midjourney/client"
require_relative "midjourney/version"

module Midjourney
  class Error < StandardError; end
  class ConfigurationError < Error; end

  class Configuration
    attr_writer :access_token
    attr_accessor :api_version, :extra_headers, :request_timeout, :uri_base

    DEFAULT_API_VERSION = "v2".freeze
    DEFAULT_URI_BASE = "https://api.midjourneyapi.io/".freeze
    DEFAULT_REQUEST_TIMEOUT = 120

    def initialize
      @access_token = nil
      @api_version = DEFAULT_API_VERSION
      @uri_base = DEFAULT_URI_BASE
      @request_timeout = DEFAULT_REQUEST_TIMEOUT
    end

    def access_token
      return @access_token if @access_token

      error_text = "Midjourney access token missing! See https://github.com/alexrudall/midjourney#usage"
      raise ConfigurationError, error_text
    end
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Midjourney::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
