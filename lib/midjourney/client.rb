module Midjourney
  class Client
    extend Midjourney::HTTP

    def initialize(access_token: nil, uri_base: nil, request_timeout: nil, extra_headers: {})
      Midjourney.configuration.access_token = access_token if access_token
      Midjourney.configuration.uri_base = uri_base if uri_base
      Midjourney.configuration.request_timeout = request_timeout if request_timeout
      Midjourney.configuration.extra_headers = extra_headers
    end

    def imagine(parameters: {})
      Midjourney::Client.json_post(path: "/imagine", parameters: parameters)
    end

    def result(parameters: {})
      Midjourney::Client.json_post(path: "/result", parameters: parameters)
    end
  end
end
