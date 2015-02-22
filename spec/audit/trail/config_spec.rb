require "spec_helper"

Audit::Trail::Adapters::Test = Module.new do
  def config
    {}
  end
end

describe Audit::Trail::Config do
  it "loads the redis adapter by default" do
    config = Audit::Trail::Config.new

    expect(config.adapter).to be_a(Audit::Trail::Adapter)
    expect(config.adapter.name).to eq("redis")
  end

  it "loads the requested adapter" do
    config = Audit::Trail::Config.new(:adapter => :test)

    expect(config.adapter).to be_a(Audit::Trail::Adapter)
    expect(config.adapter.name).to eq("test")
  end
end
