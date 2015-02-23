require "spec_helper"

describe Audit::Trail::Recorder do
  describe "#initialize" do
    context "when no config passed" do
      it "should have a default config object" do
        default_config = Audit::Trail::Config.new
        recorder = Audit::Trail::Recorder.new
        expect(recorder.config.to_h).to eq(default_config.to_h)
      end
    end
  end
end
