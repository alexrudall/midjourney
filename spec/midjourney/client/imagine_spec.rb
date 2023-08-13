RSpec.describe Midjourney::Client do
  describe "#imagine" do
    context "with a prompt", :vcr do
      let(:prompt) { "A stunning forest beneath a bright blue sky" }

      let(:response) do
        Midjourney::Client.new.imagine(
          parameters: {
            prompt: prompt
          }
        )
      end
      let(:cassette) { "imagine #{prompt}".downcase }

      it "succeeds" do
        VCR.use_cassette(cassette) do
          expect(response["taskId"].empty?).to eq(false)
        end
      end
    end
  end
end
