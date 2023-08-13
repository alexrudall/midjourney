module Midjourney
  module HTTP
    def get(path:)
      to_json(conn.get(uri(path: path)) do |req|
        req.headers = headers
      end&.body)
    end

    def json_post(path:, parameters:)
      to_json(conn.post(uri(path: path)) do |req|
        req.headers = headers
        req.body = parameters.to_json
      end&.body)
    end

    private

    def to_json(string)
      return unless string

      JSON.parse(string)
    rescue JSON::ParserError
      # Convert a multiline string of JSON objects to a JSON array.
      JSON.parse(string.gsub("}\n{", "},{").prepend("[").concat("]"))
    end

    def conn(multipart: false)
      Faraday.new do |f|
        f.options[:timeout] = Midjourney.configuration.request_timeout
        f.request(:multipart) if multipart
      end
    end

    def uri(path:)
      Midjourney.configuration.uri_base + Midjourney.configuration.api_version + path
    end

    def headers
      {
        "Content-Type" => "application/json",
        "Authorization" => Midjourney.configuration.access_token
      }.merge(Midjourney.configuration.extra_headers)
    end

    def multipart_parameters(parameters)
      parameters&.transform_values do |value|
        next value unless value.is_a?(File)

        # Doesn't seem like Midjourney needs mime_type yet, so not worth
        # the library to figure this out. Hence the empty string
        # as the second argument.
        Faraday::UploadIO.new(value, "", value.path)
      end
    end
  end
end
