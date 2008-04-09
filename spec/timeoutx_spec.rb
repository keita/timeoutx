require File.dirname(__FILE__) + '/spec_helper.rb'
$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")
require "timeoutx"

describe "timeout" do
  it "should be timeout" do
    Proc.new do
      1.upto(100000) do
        TimeoutX.timeout(0.1){sleep 0.09}
      end
    end.should raise_error(TimeoutX::Error)
  end

  it "should not be timeout" do
    Proc.new do
      1.upto(100000) do
        TimeoutX.timeout(0.09){sleep 0.1}
      end
    end.should_not raise_error(TimeoutX::Error)
  end
end
