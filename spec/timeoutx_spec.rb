$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", "lib")
require "timeoutx"
require "bacon"

describe "TimeoutX" do
  it "should be timeout" do
    Proc.new do
      TimeoutX.timeout(0.1){sleep 1}
    end.should.raise(TimeoutX::Error)
  end

  it "should not be timeout" do
    Proc.new do
      TimeoutX.timeout(1){sleep 0.1}
    end.should.not.raise(TimeoutX::Error)
  end
end
