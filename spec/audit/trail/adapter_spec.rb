require "spec_helper"

Audit::Trail::Adapters::Mock = Module.new do
  def config
    {
      :test => :default
    }
  end
end

describe Audit::Trail::Adapter do
  class TestConfig < Audit::Trail::Config
    def initialize; end
  end

  it "sets a namespace based on the name it's initialized with" do
    adapter = Audit::Trail::Adapter.new(:mock)

    expect(adapter.name).to eq("mock")
    expect(adapter.namespace).to eq("Audit::Trail::Adapters::Mock")
  end

  describe "apply_config" do
    it "creates reader and writer for each config option on the conf passed" do
      context = TestConfig.new
      adapter = Audit::Trail::Adapter.new(:mock)
      adapter.apply_config(context)

      expect(context.mock_test).to eq(:default)
      expect{context.mock_test = :new_value}.to_not raise_error
      expect(context.mock_test).to eq(:new_value)
    end

    it "raises an InvalidContextError if the object passed is invalid" do
      adapter = Audit::Trail::Adapter.new(:mock)

      expect{adapter.apply_config(Object.new)}.to(
        raise_error Audit::Trail::Adapter::InvalidContextError
      )
    end
  end
end
