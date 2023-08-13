RSpec.describe Midjourney::Client do
  describe "#result" do
    context "with a taskId", :vcr do
      let(:prompt) { "A stunning forest beneath a bright blue sky" }
      let(:taskId) do
        VCR.use_cassette("result task ID") do
          # Midjourney::Client.new.imagine(
          #   parameters: {
          #     prompt: prompt
          #   }
          # )["taskId"]
          "3830188036095935"
        end
      end
      let(:cassette) { "result #{prompt}".downcase }
      let(:response) do
        Midjourney::Client.new.result(
          parameters: {
            taskId: taskId
          }
        )
      end

      it "succeeds" do
        VCR.use_cassette(cassette) do
          expect([response["status"], response["imageURL"]].empty?).to eq(false)
        end
      end
    end
  end
end
