RSpec.describe "compatibility" do
  context "for moved constants" do
    describe "::Ruby::Midjourney::VERSION" do
      it "is mapped to ::Midjourney::VERSION" do
        expect(Ruby::Midjourney::VERSION).to eq(Midjourney::VERSION)
      end
    end

    describe "::Ruby::Midjourney::Error" do
      it "is mapped to ::Midjourney::Error" do
        expect(Ruby::Midjourney::Error).to eq(Midjourney::Error)
        expect(Ruby::Midjourney::Error.new).to be_a(Midjourney::Error)
        expect(Midjourney::Error.new).to be_a(Ruby::Midjourney::Error)
      end
    end

    describe "::Ruby::Midjourney::ConfigurationError" do
      it "is mapped to ::Midjourney::ConfigurationError" do
        expect(Ruby::Midjourney::ConfigurationError).to eq(Midjourney::ConfigurationError)
        expect(Ruby::Midjourney::ConfigurationError.new).to be_a(Midjourney::ConfigurationError)
        expect(Midjourney::ConfigurationError.new).to be_a(Ruby::Midjourney::ConfigurationError)
      end
    end

    describe "::Ruby::Midjourney::Configuration" do
      it "is mapped to ::Midjourney::Configuration" do
        expect(Ruby::Midjourney::Configuration).to eq(Midjourney::Configuration)
        expect(Ruby::Midjourney::Configuration.new).to be_a(Midjourney::Configuration)
        expect(Midjourney::Configuration.new).to be_a(Ruby::Midjourney::Configuration)
      end
    end
  end
end
