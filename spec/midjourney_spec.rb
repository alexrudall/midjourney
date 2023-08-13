RSpec.describe Midjourney do
  it "has a version number" do
    expect(Midjourney::VERSION).not_to be nil
  end

  describe "#configure" do
    let(:access_token) { "abc123" }
    let(:api_version) { "v2" }
    let(:custom_uri_base) { "ghi789" }
    let(:custom_request_timeout) { 25 }
    let(:extra_headers) { { "User-Agent" => "Midjourney Ruby Gem #{Midjourney::VERSION}" } }

    before do
      Midjourney.configure do |config|
        config.access_token = access_token
        config.api_version = api_version
        config.extra_headers = extra_headers
      end
    end

    it "returns the config" do
      expect(Midjourney.configuration.access_token).to eq(access_token)
      expect(Midjourney.configuration.api_version).to eq(api_version)
      expect(Midjourney.configuration.uri_base).to eq("https://api.midjourneyapi.io/")
      expect(Midjourney.configuration.request_timeout).to eq(120)
      expect(Midjourney.configuration.extra_headers).to eq(extra_headers)
    end

    context "without an access token" do
      let(:access_token) { nil }

      it "raises an error" do
        expect { Midjourney::Client.new.imagine }.to raise_error(Midjourney::ConfigurationError)
      end
    end

    context "with custom timeout and uri base" do
      before do
        Midjourney.configure do |config|
          config.uri_base = custom_uri_base
          config.request_timeout = custom_request_timeout
        end
      end

      it "returns the config" do
        expect(Midjourney.configuration.access_token).to eq(access_token)
        expect(Midjourney.configuration.api_version).to eq(api_version)
        expect(Midjourney.configuration.uri_base).to eq(custom_uri_base)
        expect(Midjourney.configuration.request_timeout).to eq(custom_request_timeout)
        expect(Midjourney.configuration.extra_headers).to eq(extra_headers)
      end
    end
  end
end
